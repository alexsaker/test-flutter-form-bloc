import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form/blocs/bloc.dart';
import 'package:flutter_form/blocs/form_bloc/form_state.dart' as MyFormState;

class MyFormPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FormBloc _formBloc = FormBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: BlocBuilder(
            bloc: _formBloc,
            builder: (BuildContext context, MyFormState.FormState state) {
              String textError;
              switch (state.runtimeType) {
                case FormHasErrors:
                  textError = state.props[0]['name'].toString();
                  final snackBar = SnackBar(
                    content: Text(state.props[0]['name'].toString()),
                  );
                  Future.delayed(const Duration(milliseconds: 500)).then((_) {
                    this._scaffoldKey.currentState.showSnackBar(snackBar);
                  });
                  break;
                case FormIsValid:
                  print('form is valid: $state');
                  final snackBar = SnackBar(
                    content: Text('Saved man!'),
                  );
                  Future.delayed(const Duration(milliseconds: 500)).then((_) {
                    this._scaffoldKey.currentState.showSnackBar(snackBar);
                    return Future.delayed(const Duration(milliseconds: 500));
                  }).then((_) {
                    Navigator.pop(context);
                  });
                  break;
                default:
                  break;
              }
              return _innerForm(context, textError);
            }),
      ),
    );
  }

  Center _innerForm(BuildContext context, String _textError) {
    return Center(
      child: Form(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "Name",
                    errorText: _textError ?? null,
                  ),
                  controller: controller,
                  obscureText: false,
                  onSubmitted: (value) {},
                  maxLength: 4,
                  keyboardType: TextInputType.text,
                ),
                DropdownButton(
                  isExpanded: true,
                  value: "Tokyo",
                  items: _getDropdownItems(),
                  onChanged: (String selectedCity) {
                    _showSelectedItemDialog(context, selectedCity);
                  },
                ),
              ]),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Save"),
                  onPressed: () {
                    this._formBloc.dispatch(
                          ValidateTextInput(textInput: controller.text),
                        );
                    // final snackBar = SnackBar(
                    //   content: Text('Saved man!'),
                    // );
                    // this._scaffoldKey.currentState.showSnackBar(snackBar);
                    // await Future.delayed(
                    //     const Duration(milliseconds: 3500));
                    // Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  color: Colors.amber,
                  child: Text('OpenDialog'),
                  onPressed: () {
                    _showDialog(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in ["Tokyo", "Singapour", "Bali"]) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  void _showSelectedItemDialog(BuildContext context, String selectedCity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Selected City".toUpperCase()),
          content: new Text("You just seleted $selectedCity"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("I know :-)"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

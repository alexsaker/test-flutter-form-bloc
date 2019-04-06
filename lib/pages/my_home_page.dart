import 'package:flutter/material.dart';
import 'package:flutter_form/pages/my_form_page.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Home page description'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text("Go to Form"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyFormPage()),
              );
            },
          ),
          RaisedButton(
            child: Text("Show Snack"),
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('Yay! A SnackBar!'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change!
                  },
                ),
              );
              this._scaffoldKey.currentState.showSnackBar(snackBar);
            },
          )
        ],
      ),
    );
  }
}

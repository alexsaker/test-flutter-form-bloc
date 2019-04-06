import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  @override
  FormState get initialState => InitialFormState(true, {});

  @override
  Stream<FormState> mapEventToState(
    FormEvent event,
  ) async* {
    if (event is ValidateTextInput) {
      if (event.textInput == 'toto') {
        Map<String, ArgumentError> errors = {}..addAll({
            'name': ArgumentError('You should not use toto as an input text')
          });
        yield FormHasErrors(errors: errors);
      } else if (event.textInput.isEmpty) {
        Map<String, ArgumentError> errors = {}
          ..addAll({'name': ArgumentError('Text field should not be empty')});
        yield FormHasErrors(errors: errors);
      } else {
        yield FormIsValid();
      }
    }
  }
}

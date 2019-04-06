import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FormEvent extends Equatable {
  FormEvent([List props = const []]) : super(props);
}

class ValidateTextInput extends FormEvent {
  final String textInput;
  ValidateTextInput({@required this.textInput}) : super([textInput]);

  @override
  String toString() => 'ValidateTextInput';
}

class FormValid extends FormEvent {
  FormValid() : super();

  @override
  String toString() => 'FormValid';
}

class FormError extends FormEvent {
  final Map<String, ArgumentError> error;
  FormError({@required this.error}) : super([error]);

  @override
  String toString() => 'FormInError';
}

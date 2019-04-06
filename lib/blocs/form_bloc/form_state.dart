import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FormState extends Equatable {
  FormState([List props = const []]) : super(props);
}

class InitialFormState extends FormState {
  final bool valid;
  final Map<String, ArgumentError> errors;
  InitialFormState(this.valid, this.errors);
}

class FormIsValid extends FormState {
  @override
  String toString() => 'FormIsValid';
}

class FormHasErrors extends FormState {
  final Map<String, ArgumentError> errors;
  FormHasErrors({@required this.errors}) : super([errors]);
  @override
  String toString() => 'FormHasErrors :${this.errors}';
}

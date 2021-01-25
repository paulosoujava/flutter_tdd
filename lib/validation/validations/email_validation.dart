import 'package:equatable/equatable.dart';

import '../protocols/field_validation.dart';

class EmailValidation extends Equatable implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = email?.isNotEmpty != true || regex.hasMatch(email);

    return isValid ? null : 'Campo inválido';
  }

  @override
  List<Object> get props => [field];
}

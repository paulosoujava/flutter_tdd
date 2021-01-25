import 'package:equatable/equatable.dart';

import '../protocols/field_validation.dart';

class UserNameValidation extends Equatable implements FieldValidation {
  final String field;

  UserNameValidation(this.field);

  String validate(String username) {
    final isValid = username?.isNotEmpty != true || username.length >= 3;

    return isValid ? null : 'Campo inválido';
  }

  @override
  List<Object> get props => [field];
}

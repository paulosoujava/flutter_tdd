import '../protocols/field_validation.dart';

class UserNameValidation implements FieldValidation {
  final String field;

  UserNameValidation(this.field);

  String validate(String username) {
    final isValid = username?.isNotEmpty != true || username.length <= 3;

    return isValid ? null : 'Campo inválido';
  }
}

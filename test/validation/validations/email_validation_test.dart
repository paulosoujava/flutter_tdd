import 'package:flutter_application_1/validation/protocols/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = email?.isNotEmpty != true || regex.hasMatch(email);

    return isValid ? null : 'Campo inválido';
  }
}

void main() {
  EmailValidation sut;
  setUp(() {
    sut = EmailValidation('any_Email');
  });

  test('Should retrurn null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should retrurn null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should retrurn null if email is valid', () {
    expect(sut.validate('valid@email.com'), null);
  });

  test('Should retrurn null if email is valid', () {
    expect(sut.validate('invalidemail.com'), 'Campo inválido');
  });
}

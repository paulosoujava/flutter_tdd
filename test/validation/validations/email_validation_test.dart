import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/validation/validations/validations.dart';

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

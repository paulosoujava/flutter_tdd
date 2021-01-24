import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/validation/validations/validations.dart';

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_value');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is  empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

  test('Should return error if value is  null', () {
    expect(sut.validate(null), 'Campo obrigatório');
  });
}

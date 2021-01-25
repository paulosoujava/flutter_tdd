import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import 'package:flutter_application_1/validation/validations/validation_composite.dart';
import 'package:flutter_application_1/validation/protocols/protocols.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;

  void mockValidation(FieldValidationSpy validation, String error) {
    when(validation.validate(any)).thenReturn(error);
  }

  void mockValidationAnyField(FieldValidationSpy validation, String str) {
    when(validation.field).thenReturn(str);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();

    mockValidationAnyField(validation1, "any_field");
    mockValidation(validation1, null);

    mockValidationAnyField(validation2, "any_field");
    mockValidation(validation2, null);

    mockValidationAnyField(validation3, "any_field");
    mockValidation(validation3, null);

    sut = ValidationComposite([validation1, validation2]);
  });

  test('Should return null if all returns null or empty', () {
    mockValidation(validation1, '');
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Should return the first error', () {
    mockValidation(validation1, 'error_1');
    mockValidation(validation2, 'error_2');
    mockValidation(validation3, 'error_3');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_1');
  });

  test('Should return the first error of the field', () {
    mockValidation(validation1, null);
    mockValidation(validation2, 'error_2');
    mockValidation(validation3, 'error_3');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_2');
  });
}

import 'package:flutter_application_1/validation/protocols/protocols.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'package:flutter_application_1/presentention/protocols/protocols.dart';
import 'package:mockito/mockito.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({@required String field, @required String value}) {
    return null;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;

  void moackValidation(FieldValidationSpy validation, String error) {
    when(validation.validate(any)).thenReturn(error);
  }

  void moackValidationAnyField(FieldValidationSpy validation) {
    when(validation.field).thenReturn("any_field");
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();

    moackValidationAnyField(validation1);
    moackValidation(validation1, null);

    moackValidationAnyField(validation2);
    moackValidation(validation2, '');

    moackValidationAnyField(validation3);
    moackValidation(validation2, 'other_field');

    sut = ValidationComposite([validation1, validation2]);
  });

  test('Should return null if all returns null or empty', () {
    final error = sut.validate(field: 'any_value', value: 'any_value');

    expect(error, null);
  });
}

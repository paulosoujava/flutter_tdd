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
  when(validation1.field).thenReturn('any_field');
  FieldValidationSpy validation2;

  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
  });

  test('Should return null if all returns null or empty', () {
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate(any)).thenReturn(null);
    when(validation2.field).thenReturn('any_field');
    when(validation2.validate(any)).thenReturn('');

    sut = ValidationComposite([validation1, validation2]);

    final error = sut.validate(field: 'any_value', value: 'any_value');

    expect(error, null);
  });
}

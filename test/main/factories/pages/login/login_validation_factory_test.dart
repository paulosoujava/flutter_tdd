import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/validation/validations/username_validation.dart';
import 'package:flutter_application_1/main/factories/pages/login/login_validation_factory.dart';
import 'package:flutter_application_1/validation/validations/required_fields_validation.dart';

void main() {
  setUp(() {});

  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('username'),
      UserNameValidation('username'),
      RequiredFieldValidation('password'),
    ]);
  });
}

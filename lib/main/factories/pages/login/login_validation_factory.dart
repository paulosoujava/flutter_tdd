import '../../../../presentention/protocols/protocols.dart';
import '../../../../validation/validations/validations.dart';

Validation makeLLoginValidation() {
  return ValidationComposite([
    RequiredFieldValidation('email'),
    RequiredFieldValidation('password'),
    EmailValidation('email'),
  ]);
}

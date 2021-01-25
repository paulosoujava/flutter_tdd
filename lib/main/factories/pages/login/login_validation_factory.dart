import '../../../../presentention/protocols/protocols.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../validation/validations/username_validation.dart';
import '../../../../validation/validations/validations.dart';

Validation makeLLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    RequiredFieldValidation('username'),
    RequiredFieldValidation('password'),
    UserNameValidation('username'),
  ];
}

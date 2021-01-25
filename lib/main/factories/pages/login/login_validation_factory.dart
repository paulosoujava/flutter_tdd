import '../../../builders/builders.dart';
import '../../../../presentention/protocols/protocols.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../validation/validations/validations.dart';

Validation makeLLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('username').required().username().build(),
    ...ValidationBuilder.field('password').required().build(),
  ];
}

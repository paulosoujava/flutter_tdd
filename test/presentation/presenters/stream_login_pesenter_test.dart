import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_application_1/presentention/presenters/presenters.dart';
import 'package:flutter_application_1/presentention/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  PostExpectation mockValidationCall(String field) => when(validation.validate(field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation(); //mock to success
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'string error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'string error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    // nao notificar duas vezes, isso se da por conta do distinct no stream_login_presenter
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validate success', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    // nao notificar duas vezes, isso se da por conta do distinct no stream_login_presenter
    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}

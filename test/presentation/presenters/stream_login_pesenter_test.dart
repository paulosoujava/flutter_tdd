import 'package:faker/faker.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/domain/entities/account_entity.dart';
import 'package:flutter_application_1/domain/usecases/usecases.dart';
import 'package:flutter_application_1/presentention/presenters/presenters.dart';
import 'package:flutter_application_1/presentention/protocols/protocols.dart';
import 'package:flutter_application_1/domain/helpers/helpers.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  ValidationSpy validation;
  AuthenticationSpy authentication;
  StreamLoginPresenter sut;
  String email;
  String password;

  PostExpectation mockValidationCall(String field) => when(validation.validate(field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => AccountEntity(faker.guid.guid()));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation(); //mock to success
    mockAuthentication();
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

  test('Should call validation with correct password', () {
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(value: 'string error');

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'string error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    // nao notificar duas vezes, isso se da por conta do distinct no stream_login_presenter
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password error if validation succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    // nao notificar duas vezes, isso se da por conta do distinct no stream_login_presenter
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit error only email input and password is ok', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit error only password input and email is ok', () {
    mockValidation(field: 'password', value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit error only password input and email is ok', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication.auth(AuthenticationParams(email: email, password: password))).called(1);
  });

  test('Should emit correct events on Authentication success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadStream, emitsInOrder([true, false]));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'invalid credentials')));

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'unexpectedError')));

    await sut.auth();
  });
}

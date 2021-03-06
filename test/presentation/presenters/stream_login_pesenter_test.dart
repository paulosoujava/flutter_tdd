import 'package:faker/faker.dart';
import 'package:flutter_application_1/domain/entities/token_entity.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/domain/usecases/usecases.dart';
import 'package:flutter_application_1/presentention/presenters/presenters.dart';
import 'package:flutter_application_1/presentention/protocols/protocols.dart';
import 'package:flutter_application_1/domain/helpers/helpers.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

class SaveCurrentTokenSpy extends Mock implements SaveCurrentToken {}

void main() {
  ValidationSpy validation;
  AuthenticationSpy authentication;
  StreamLoginPresenter sut;
  SaveCurrentTokenSpy saveCurrentToken;
  String username;
  String password;
  String token;

  PostExpectation mockValidationCall(String field) => when(validation.validate(field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => Token(token));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  PostExpectation mockSaveCurrentTokenCall() => when(saveCurrentToken.saveToken(any));
  void mockSaveCurrentTokenError() {
    mockSaveCurrentTokenCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    saveCurrentToken = SaveCurrentTokenSpy();
    sut = StreamLoginPresenter(
      validation: validation,
      authentication: authentication,
      saveCurrentToken: saveCurrentToken,
    );
    username = faker.internet.userName();
    password = faker.internet.password();
    token = faker.guid.guid();
    mockValidation(); //mock to success
    mockAuthentication();
  });

  test('Should call validation with correct username', () {
    sut.validateUserName(username);

    verify(validation.validate(field: 'username', value: username)).called(1);
  });

  test('Should emit username error if validation fails', () {
    mockValidation(value: 'string error');

    sut.usernameErrorStream.listen(expectAsync1((error) => expect(error, 'string error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    // nao notificar duas vezes, isso se da por conta do distinct no stream_login_presenter
    sut.validateUserName(username);
    sut.validateUserName(username);
  });

  test('Should emit null if validate success', () {
    sut.usernameErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    // nao notificar duas vezes, isso se da por conta do distinct no stream_login_presenter
    sut.validateUserName(username);
    sut.validateUserName(username);
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

  test('Should emit error only username input and password is ok', () {
    mockValidation(field: 'username', value: 'error');

    sut.usernameErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateUserName(username);
    sut.validatePassword(password);
  });

  test('Should emit error only password input and username is ok', () {
    mockValidation(field: 'password', value: 'error');

    sut.usernameErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateUserName(username);
    sut.validatePassword(password);
  });

  test('Should emit error only password input and username is ok', () async {
    sut.usernameErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateUserName(username);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call authentication with correct values', () async {
    sut.validateUserName(username);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication.auth(AuthenticationParams(username: username, password: password))).called(1);
  });

  test('Should emit correct events on Authentication success', () async {
    sut.validateUserName(username);
    sut.validatePassword(password);

    expectLater(sut.isLoadStream, emits(true));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateUserName(username);
    sut.validatePassword(password);

    expectLater(sut.isLoadStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'invalid credentials')));

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validateUserName(username);
    sut.validatePassword(password);

    expectLater(sut.isLoadStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'unexpectedError')));

    await sut.auth();
  });

  test('Should call SaveCurrentToken whith correct value', () async {
    sut.validateUserName(username);
    sut.validatePassword(password);
    await sut.auth();
    verify(saveCurrentToken.saveToken(Token(token))).called(1);
  });

  // test('Should emit UnexpectedError if SaveCurrentToken fails', () async {
  //   mockSaveCurrentTokenError();
  //   sut.validateUserName(username);
  //   sut.validatePassword(password);

  //   sut.mainErrorStream.listen(expectAsync1((error) => expect(error, null)));

  //   await sut.auth();
  // });
  test('Should change page on success', () async {
    sut.validateUserName(username);
    sut.validatePassword(password);
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/home')));

    await sut.auth();
  });
  test('Should not emit after dispose', () async {
    expectLater(sut.usernameErrorStream, neverEmits(null));
    sut.dispose();
    sut.validateUserName(username);
  });
}

import 'dart:async';

import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

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

    expectLater(sut.emailErrorStream, emits('string error'));
    sut.validateEmail(email);
  });
}

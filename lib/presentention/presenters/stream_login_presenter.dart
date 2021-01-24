import 'dart:async';

import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

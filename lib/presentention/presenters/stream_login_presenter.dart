import 'dart:async';

import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';
import '../protocols/protocols.dart';
import '../../domain/usecases/usecases.dart';
import '../../domain/helpers/helpers.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  String mainError;
  bool isLoad = false;

  bool get isFormValid => emailError == null && passwordError == null && email != null && password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  var _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  StreamLoginPresenter({@required this.validation, @required this.authentication});

  Stream<String> get emailErrorStream => _controller?.stream?.map((state) => state.emailError)?.distinct();
  Stream<String> get passwordErrorStream => _controller?.stream?.map((state) => state.passwordError)?.distinct();
  Stream<String> get mainErrorStream => _controller?.stream?.map((state) => state.mainError)?.distinct();
  Stream<bool> get isFormValidStream => _controller?.stream?.map((state) => state.isFormValid)?.distinct();
  Stream<bool> get isLoadStream => _controller?.stream?.map((state) => state.isLoad)?.distinct();

  void _update() => _controller?.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(field: 'password', value: password);
    _update();
  }

  Future<void> auth() async {
    _toggeLoading(true);
    try {
      await authentication.auth(AuthenticationParams(email: _state.email, password: _state.password));
    } on DomainError catch (error) {
      _state.mainError = error.description;
    }

    _toggeLoading(false);
  }

  void dispose() {
    _controller?.close();
    _controller = null;
  }

  _toggeLoading(bool isShow) {
    _state.isLoad = isShow;
    _update();
  }
}

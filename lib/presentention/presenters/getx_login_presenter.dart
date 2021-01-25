import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import '../../ui/pages/pages.dart';
import '../protocols/protocols.dart';
import '../../domain/usecases/usecases.dart';
import '../../domain/helpers/helpers.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  String _username;
  String _password;
  var _usernameError = RxString(); // começa com null
  var _passwordError = RxString();
  var _mainError = RxString();
  var _isLoad = false.obs; // cp,eca co o valor default false
  var _isFormValid = false.obs; // cp,eca co o valor default false

  GetxLoginPresenter({@required this.validation, @required this.authentication});

  Stream<String> get usernameErrorStream => _usernameError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;
  Stream<String> get mainErrorStream => _mainError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadStream => _isLoad.stream;

  void validateUserName(String username) {
    _username = username;
    _usernameError.value = validation.validate(field: 'username', value: username);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _usernameError.value == null && _passwordError.value == null && _username != null && _password != null;
  }

  Future<void> auth() async {
    _isLoad.value = true;
    try {
      await authentication.auth(AuthenticationParams(username: _username, password: _password));
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }

    _isLoad.value = false;
  }
}

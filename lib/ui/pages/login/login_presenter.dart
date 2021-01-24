abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<bool> get isFormValidController;
  Stream<bool> get isLoadController;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}

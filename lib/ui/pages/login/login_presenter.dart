abstract class LoginPresenter {
  Stream<String> get usernameErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<String> get mainErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadStream;

  void validateUserName(String username);
  void validatePassword(String password);
  Future<void> auth();
  void dispose();
}

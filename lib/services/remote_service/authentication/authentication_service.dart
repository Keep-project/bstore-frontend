
abstract class RemoteAuthenticationService {
  Future<void> login({
    String? login,
    String? password,
    Function(dynamic data)? onLoginSuccess,
    Function(dynamic error)? onLoginError,
  });

  Future<void> register({
    // RequestUserModel? userModel,
    Function(dynamic data)? onRegisterSuccess,
    Function(dynamic error)? onRegisterError,
  });
}
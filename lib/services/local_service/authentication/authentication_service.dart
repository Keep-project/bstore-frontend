
abstract class LocalAuthenticationServices {
  Future<bool> saveToken(String token);
  Future<void> saveUser(String user);
  Future<String?> getUser();
  Future<String?> getToken();
  Future<bool> deleteToken();
  Future<bool> hasAuthToken();
}
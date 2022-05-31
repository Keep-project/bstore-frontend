
abstract class LocalAuthenticationServices {
  Future<bool> saveToken(String token);
  Future<String?> getToken();
  Future<bool> deleteToken();
  Future<bool> hasAuthToken();
}
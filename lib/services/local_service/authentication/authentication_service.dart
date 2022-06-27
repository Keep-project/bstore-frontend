
abstract class LocalAuthenticationServices {
  Future<bool> saveToken(String token);
  Future<void> saveUser(String user);
  Future<void> saveBookId(String id);
  Future<String?> getUser();
  Future<String?> getBookId();
  Future<String?> getToken();
  Future<bool> deleteToken();
  Future<bool> deleteBookId();
  Future<bool> hasAuthToken();
}


abstract class UserService {
  Future<void> getUser({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,}
  );
  Future<void> updateUserData({
    int? userId,
    dynamic userData,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,}
  );
}
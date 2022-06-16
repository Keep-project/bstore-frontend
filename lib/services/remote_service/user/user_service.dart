

abstract class UserService {
  Future<void> getUser({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,}
  );
}
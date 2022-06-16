import 'package:bstore/core/api_library.dart';
import 'package:bstore/core/constants.dart';
import 'package:bstore/services/remote_service/user/user_service.dart';

class UserServiceImpl implements UserService {
  @override
  Future<void> getUser(
      {Function(dynamic data)? onSuccess, Function(dynamic error)? onError}) async {
        ApiRequest(
          url: "${Constants.API_URL}/book/",
        ).get(
          
        );
  }
}

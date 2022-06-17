import 'package:bstore/core/api_library.dart';
import 'package:bstore/core/constants.dart';
import 'package:bstore/models/response_data_model.dart/user_data.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/user/user_service.dart';

class UserServiceImpl implements UserService {
  final LocalAuthenticationServices _localAuth  = LocalAuthenticationServicesImpl();

  @override
  Future<void> getUser(
      {Function(dynamic data)? onSuccess, Function(dynamic error)? onError}) async {
        ApiRequest(
          url: "${Constants.API_URL}/book/utilisateur/info/",
          data: {},
          token: await _localAuth.getToken(),
        ).get(
          onSuccess: (data){
            onSuccess!(UserRequestModel.fromMap(data));
          },
          onError: (error){
            if ( error != null){
              onError!(error);
            }
          }
        );
  }
}

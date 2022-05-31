
import 'package:bstore/models/request_data_model.dart/login_model.dart';
import 'package:bstore/models/request_data_model.dart/register_model.dart';

abstract class RemoteAuthenticationService {
  Future<void> login({
    LoginRequestModel? loginReqModel,
    Function(dynamic data)? onLoginSuccess,
    Function(dynamic error)? onLoginError,
  });

  Future<void> register({
    RegisterRequestModel? registerReqModel,
    Function(dynamic data)? onRegisterSuccess,
    Function(dynamic error)? onRegisterError,
  });
}


import 'package:bstore/core/api_library.dart';
import 'package:bstore/core/constants.dart';
import 'package:bstore/models/request_data_model.dart/login_model.dart';
import 'package:bstore/models/request_data_model.dart/register_model.dart';
import 'package:bstore/models/response_data_model.dart/token_model.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service.dart';

class RemoteAuthenticationServiceImpl implements RemoteAuthenticationService {


  @override
  Future<void> login({
    LoginRequestModel? loginReqModel,
    Function(dynamic data)? onLoginSuccess,
    Function(dynamic error)? onLoginError}) async {

      ApiRequest(
        url: "${Constants.API_URL}/jwt/create",
        // data: <String, String>{"username": "$login","password": "$password"},
        data: loginReqModel!.toMap(),
      ).post(
        onSuccess: (data){
          onLoginSuccess!(TokenReponseModel.fromMap(data));
        },
        onError: (error){
          if (error != null) { onLoginError!(error);}
        }
      );
    
  }

  @override
  Future<void> register({
    RegisterRequestModel? registerReqModel,
    Function(dynamic data)? onRegisterSuccess,
    Function(dynamic error)? onRegisterError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/book/utilisateur/",
      data: registerReqModel!.toMap(),
    ).post(
       onSuccess: (data){
          onRegisterSuccess!(data);
        },
        onError: (error){
          if (error != null) { onRegisterError!(error);}
        }
    );
  } 

}
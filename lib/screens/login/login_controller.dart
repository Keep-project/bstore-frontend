
// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bstore/models/request_data_model.dart/login_model.dart';
import 'package:bstore/models/response_data_model.dart/user_data.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/user/user_service.dart';
import 'package:bstore/services/remote_service/user/user_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController{
  final RemoteAuthenticationService _authService =  RemoteAuthenticationServiceImpl();
  final LocalAuthenticationServices _localAuth = LocalAuthenticationServicesImpl();

  final UserService _userService = UserServiceImpl();

  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingPassword = TextEditingController();

  @override 
  void onInit() async {
    super.onInit();
  }
  @override
  void dispose() {
    textEditingNom.dispose();
    textEditingPassword.dispose();
    super.dispose();
  }

  Future getUser() async {

    await _userService.getUser(
      onSuccess: (data) async {
        await _localAuth.saveUser(json.encode(data.results!.toMap()));
        Get.offAllNamed(AppRoutes.HOME);
          var  userString = await _localAuth.getUser();
          var userJson = json.decode(userString!);
          User user = User.fromMap(userJson);
          print(userJson);
          print("\n\n");
          // print(userJson['likedBooks']);
          // print("\n\n");
          // print(userJson['downloadsBooks']);
          // print("\n\n");
          // print(userJson['uploadsBooks']);
        
      },

      onError: (error) {
        print("================== login / info =================");
        print(error);
        print("=================================================");
      }
    );
  }


  Future login() async{
    await _authService.login(
      loginReqModel: LoginRequestModel(
        username: textEditingNom.text.trim(),
        password: textEditingPassword.text.trim()
      ),

      onLoginSuccess: (data) async{
        // textEditingNom.clear();
        // textEditingPassword.clear();
        await _localAuth.saveToken(data.access);
        await getUser();
      },
      onLoginError: (error){
        print("============ Login =============");
        if (error.response!.statusCode == 401){
          print("Compte inexistant");
        }
        print("Une erreur est survenue ${error.response!.data}");
        print("================================");
      }
    );
  }
}
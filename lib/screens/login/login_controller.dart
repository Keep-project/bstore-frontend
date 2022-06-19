// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bstore/core/app_state.dart';
import 'package:bstore/models/request_data_model.dart/login_model.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/user/user_service.dart';
import 'package:bstore/services/remote_service/user/user_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final RemoteAuthenticationService _authService =
      RemoteAuthenticationServiceImpl();
  final LocalAuthenticationServices _localAuth =
      LocalAuthenticationServicesImpl();

      LoadingStatus loginStatus = LoadingStatus.initial;

  final UserService _userService = UserServiceImpl();

  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingPassword = TextEditingController();

  @override
  void dispose() {
    textEditingNom.dispose();
    textEditingPassword.dispose();
    super.dispose();
  }

  Future getUser() async {
    await _userService.getUser(onSuccess: (data) async {
      await _localAuth.saveUser(json.encode(data.results!.toMap()));
      // Map<String, dynamic> userJson = await UserInfo.user();
      Future.delayed(const Duration(seconds: 3), (){
        Get.offAllNamed(AppRoutes.HOME);
        loginStatus = LoadingStatus.completed;
        update();
      }) ;
    },

    onError: (error) {
      print("================== login / info =================");
      print(error);
      print("=================================================");
    });
  }

  Future login() async {
    loginStatus = LoadingStatus.searching;
    update();
    await _authService.login(
        loginReqModel: LoginRequestModel(
            username: textEditingNom.text.trim(),
            password: textEditingPassword.text.trim()),
        onLoginSuccess: (data) async {
          textEditingNom.clear();
          textEditingPassword.clear();
          await _localAuth.saveToken(data.access);
          await getUser();
        },
        onLoginError: (error) {
          print("============ Login =============");
          if (error.response!.statusCode == 401) {
            print("Compte inexistant");
          }
          print("Une erreur est survenue ${error.response!.data}");
          print("================================");
          loginStatus = LoadingStatus.failed;
          update();
        });
  }
}

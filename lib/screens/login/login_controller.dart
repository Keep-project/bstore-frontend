
// ignore_for_file: avoid_print

import 'package:bstore/router/app_router.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController{
  final RemoteAuthenticationService _authService =  RemoteAuthenticationServiceImpl();

  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingPassword = TextEditingController();

  // @override 
  // void onInit() {
  //   super.onInit();
  // }
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future login() async{
    print("Log in");
    print({'nom': textEditingNom.text.trim(), 'password': textEditingPassword.text.trim()});
    Get.toNamed(AppRoutes.HOME);

    // await _authService.login(
    //   login: textEditingNom.text.trim(),
    //   password: textEditingPassword.text.trim(),
    //   onLoginSuccess: (data){
    //     print("Login success $data");
    //   },
    //   onLoginError: (error){
    //     print("============ Login =============");
    //     print("Une erreur est survenue $error");
    //     print("================================");
    //   }
    // );
  }
}
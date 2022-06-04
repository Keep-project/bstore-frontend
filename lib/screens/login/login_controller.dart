
// ignore_for_file: avoid_print

import 'package:bstore/models/request_data_model.dart/login_model.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController{
  final RemoteAuthenticationService _authService =  RemoteAuthenticationServiceImpl();
  final LocalAuthenticationServices _localAuth = LocalAuthenticationServicesImpl();

  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingPassword = TextEditingController();

  @override 
  void onInit() async {
    await verifyToken();
    super.onInit();
  }
  @override
  void dispose() {
    textEditingNom.dispose();
    textEditingPassword.dispose();
    super.dispose();
  }

  Future verifyToken() async{
    if ( await _localAuth.hasAuthToken()){
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.toNamed(AppRoutes.HOME);
      });
      
    }
    else{
      print("User hasn't token");
    }
  }

  Future login() async{
   
    await _authService.login(
      loginReqModel: LoginRequestModel(
        username: textEditingNom.text.trim(),
        password: textEditingPassword.text.trim()
      ),
      onLoginSuccess: (data) async{
        textEditingNom.clear();
        textEditingPassword.clear();
        await _localAuth.saveToken(data.access);
        Get.toNamed(AppRoutes.HOME);
      },
      onLoginError: (error){
        print("============ Login =============");
        print("Une erreur est survenue ${error.response!.data}");
        print("================================");
      }
    );
  }
}
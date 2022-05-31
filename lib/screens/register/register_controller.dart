// ignore_for_file: avoid_print

import 'package:bstore/models/request_data_model.dart/register_model.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service.dart';
import 'package:bstore/services/remote_service/authentication/authentication_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController{

final RemoteAuthenticationService _authService = RemoteAuthenticationServiceImpl();
final TextEditingController textEditingNom = TextEditingController();
final TextEditingController textEditingEmail = TextEditingController();
final TextEditingController textEditingPassword = TextEditingController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future register() async {
    await _authService.register(
      registerReqModel: RegisterRequestModel(
        username: textEditingNom.text.trim(),
        email: textEditingEmail.text.trim(),
        password: textEditingPassword.text.trim(),
      ),
      onRegisterSuccess: (data){
        print("============== Register ================");
        print(data);
        print("========================================");
      },
      onRegisterError: (error){
        print("============ Register ===========");
        print("Erreur est survenue ${error.response!.data}");
        print("=================================");
      },
    );
  }
}
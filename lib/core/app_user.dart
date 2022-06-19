// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';

class UserInfo {
  
  
  static Future<dynamic> user() async {
    final LocalAuthenticationServices _localAuth =
      LocalAuthenticationServicesImpl();
    var userString = await _localAuth.getUser();
    var userJson = json.decode(userString!);
    return userJson;
  }
}

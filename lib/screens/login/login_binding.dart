

import 'package:bstore/screens/login/login.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
  }
}
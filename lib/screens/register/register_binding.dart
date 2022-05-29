
import 'package:bstore/screens/register/register.dart';
import 'package:get/get.dart';

class RegisterScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
  }
}
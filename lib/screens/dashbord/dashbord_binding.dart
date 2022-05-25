
import 'package:bstore/screens/dashbord/dashbord.dart';
import 'package:get/get.dart';

class ProfilScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilScreenController());
  }
}
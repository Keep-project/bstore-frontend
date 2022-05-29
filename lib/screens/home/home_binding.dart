

import 'package:bstore/screens/home/home.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
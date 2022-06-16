
import 'package:bstore/screens/splashscreen/splashscreen_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}

import 'package:bstore/router/app_router.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController{

  final LocalAuthenticationServices _localAuth = LocalAuthenticationServicesImpl();


  @override 
  void onInit() async {
    await verifyToken();
    super.onInit();
  }

  Future verifyToken() async{
    if ( await _localAuth.hasAuthToken()){
      Future.delayed(const Duration(milliseconds: 1000), () {
        //Get.offAllNamed(AppRoutes.LOGIN);
        Get.offAllNamed(AppRoutes.HOME);
      });
    }
    else{
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
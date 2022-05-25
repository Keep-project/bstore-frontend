


import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/dashbord/dashbord.dart';
import 'package:bstore/screens/details/detail.dart';
import 'package:bstore/screens/home/home.dart';
import 'package:bstore/screens/login/login.dart';
import 'package:bstore/screens/register/register.dart';
import 'package:get/get.dart';

class AppPages{

  static final pages = [
    GetPage(
        name: AppRoutes.HOME,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding()),
    
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => const LoginScreen(),
        binding: LoginScreenBinding()),

    GetPage(
        name: AppRoutes.REGISTER,
        page: () => const RegisterScreen(),
        binding: RegisterScreenBinding()),

    GetPage(
        name: AppRoutes.DETAILS,
        page: () => const DetailScreen(),
        binding: DetailScreenBinding()),
    
    GetPage(
        name: AppRoutes.DASHBORD,
        page: () => const ProfilScreen(),
        binding: ProfilScreenBinding()),
  ];

}
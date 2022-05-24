


import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/home/home.dart';
import 'package:get/get.dart';

class AppPages{

  static final pages = [
    GetPage(
        name: AppRoutes.HOME,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding()),
  ];

}
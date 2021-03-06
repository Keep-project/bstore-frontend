import 'package:bstore/core/app_colors.dart';
import 'package:bstore/router/app_pages.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const App());
}

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        // primarySwatch: kPrimaryColor,
        scaffoldBackgroundColor: kColorWhite,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.SPLASHSCREEN,
    );
  }
}

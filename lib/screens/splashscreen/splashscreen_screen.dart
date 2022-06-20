import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/splashscreen/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SplashScreenController>(
          builder: (controller) {
            return  Container(
              height: Get.height,
              width: Get.width,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    Container(
                      width: 120,
                      decoration: const BoxDecoration(
                      ),
                      child: Image.asset("assets/images/bstore-logo.png",
                      fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding*2),
                    const Text("Book Store", 
                      style: TextStyle(
                        color: kDarkColor90,
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding*1.6),
                    const Text("Votre application de partage\n de documents important", 
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kDarkColor90,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    
                    const Spacer(flex: 2),
                  ],
                ),
            );
          }
        ),
      ));
  }
}
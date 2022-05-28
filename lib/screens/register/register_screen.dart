import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlueDark,
        body: Container(
          padding: const EdgeInsets.all(0),
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              const Spacer(),
              const Center(
                child: Text("Logo",
                  style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: Get.height * 0.65,
                decoration: const BoxDecoration(
                  color:kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultRadius*4),
                    bottomRight: Radius.circular(kDefaultRadius*4),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}


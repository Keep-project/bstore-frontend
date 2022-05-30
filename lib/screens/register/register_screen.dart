// ignore_for_file: avoid_print

import 'package:bstore/components/custom_button.dart';
import 'package:bstore/components/custom_text_field.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlueDark,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0),
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const Spacer(),
                const Center(
                  child: Text(
                    "Logo",
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
                    width: Get.width,
                    decoration: const BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kDefaultRadius * 4),
                        bottomRight: Radius.circular(kDefaultRadius * 4),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Créer un compte",
                            style: TextStyle(
                              color: kDarkColor86,
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          const CustomTextField(
                            hintText: "Entrez votre nom",
                            helpText: "Nom",
                          ),
                          const SizedBox(height: 20),
                          const CustomTextField(
                            hintText: "Entrez votre email",
                            helpText: "Email",
                          ),
                          const SizedBox(height: kDefaultPadding),
                          const CustomTextField(
                            hintText: "Entrez votre mot de passe",
                            helpText: "Mot de passe",
                          ),
                          const Spacer(),
                          CustomButton(onTap: (){Get.toNamed(AppRoutes.LOGIN);},),
                          
                          const Spacer(),
                        ],
                      ),
                    )),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// ignore_for_file: avoid_print

import 'package:bstore/components/custom_button.dart';
import 'package:bstore/components/custom_pass_field.dart';
import 'package:bstore/components/custom_text_field.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder<LoginScreenController>(
            builder: (controller) {
              return Container(
                padding: const EdgeInsets.all(0),
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(),
                      child: Image.asset("assets/images/bstore-logo.png", fit: BoxFit.contain),
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
                                "Connexion",
                                style: TextStyle(
                                  color: kDarkColor86,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: controller.textEditingNom,
                                hintText: "Entrez votre nom",
                                helpText: "Nom",
                              ),
                              const SizedBox(height: kDefaultPadding),
                              CustomPassField(
                                obscureText: controller.obscureText,
                                onTap: () {
                                  controller.obscureText = !controller.obscureText;
                                  controller.update();
                                },
                                controller: controller.textEditingPassword,
                                hintText: "Entrez votre mot de passe",
                                helpText: "Mot de passe",
                              ),
                             const SizedBox(height: kDefaultPadding*3),
                            controller.loginStatus == LoadingStatus.searching ?
                            Container(
                              height: 45,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: const Center(
                                child: CircularProgressIndicator(color: kOrangeColor,),
                              ),
                            ) :
                              CustomButton(
                                title: "Se connecter",
                                onTap: () async { await controller.login(context);},),
                              const SizedBox(height: kDefaultPadding),
                              Row(
                                children: [
                                  const Text("Avez-vous un compte? ",
                                    style: TextStyle(
                                      color: kDarkColor90,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {Get.toNamed(AppRoutes.REGISTER);},
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text("Créer un compte",
                                        style: TextStyle(
                                          color: kOrangeColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    const Spacer(flex: 2),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}




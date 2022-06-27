// ignore_for_file: avoid_print

import 'package:bstore/components/custom_button.dart';
import 'package:bstore/components/custom_text_field.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterScreenController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: kBlueDark,
        body: GetBuilder<RegisterScreenController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
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
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: kWhiteColor,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 1.5),
                          child: Column(
                            children: [
                              const SizedBox(height: kDefaultPadding/2),
                              const Text(
                                "Créer un compte",
                                style: TextStyle(
                                  color: kDarkColor86,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                ),
                              ),
                              
                              const SizedBox(height: kDefaultPadding*0.6),
                              CustomTextField(
                                controller: controller.textEditingNom,
                                hintText: "Entrez votre nom",
                                helpText: "Nom",
                              ),
                              const SizedBox(height: kDefaultPadding*0.6),
                              CustomTextField(
                                controller: controller.textEditingEmail,
                                hintText: "Entrez votre email",
                                helpText: "Email",
                              ),
                              const SizedBox(height: kDefaultPadding*0.6),
                              CustomTextField(
                                controller: controller.textEditingPassword,
                                hintText: "Entrez votre mot de passe",
                                helpText: "Mot de passe",
                              ),
                              const SizedBox(height: kDefaultPadding*3),
                              controller.registerStatus == LoadingStatus.searching ?
                            Container(
                              height: 45,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: const Center(
                                child: CircularProgressIndicator(color: kOrangeColor,),
                              ),
                            ) :
                              CustomButton(
                                title: "Créer mon compte",
                                onTap: ()async{ await controller.register(context);},),
                              const SizedBox(height: kDefaultPadding),
                              Row(
                                children: [
                                  const Text("Avez-vous un compte? ",
                                    style: TextStyle(
                                      color: kDarkColor90,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {Get.toNamed(AppRoutes.LOGIN);},
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text("Connectez-vous",
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
              ),
            );
          }
        ),
      ),
    );
  }
}




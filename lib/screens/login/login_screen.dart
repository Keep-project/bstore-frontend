// ignore_for_file: avoid_print

import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                            "Connexion",
                            style: TextStyle(
                              color: kDarkColor86,
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: "Entrez votre nom",
                            helpText: "Nom",
                            onChanged: (string) {
                              print("Bonjour Jeni");
                            },
                          ),
                          const SizedBox(height: kDefaultPadding),
                          CustomTextField(
                            hintText: "Entrez votre prénom",
                            helpText: "Prénom",
                            onChanged: (string) {
                              print("Bonjour je suis john");
                            },
                          ),
                          const Spacer(),
                          CustomButton(onTap: (){Get.toNamed(AppRoutes.HOME);},),
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

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  const CustomButton({
    Key? key, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {onTap!();},
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2,
            vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
            color: kOrangeColor,
            borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Text("Enregistrer",
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? helpText;
  final Function(String text)? onChanged;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.helpText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$helpText",
          style: const TextStyle(
            fontSize: 16,
            color: kDarkColor90,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.4),
              borderRadius: BorderRadius.circular(8)),
          child: TextField(
            onChanged: (string) {
              onChanged!(string);
            },
            style: const TextStyle(
              fontSize: 16,
              color: kDarkColor90,
            ),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.only(
                  left: kDefaultPadding / 2,
                  top: kDefaultPadding / 4,
                  right: kDefaultPadding / 2,
                  bottom: kDefaultPadding / 4),
              hintText: '$hintText',
              hintStyle: TextStyle(
                fontSize: 16,
                color: kDarkColor90.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

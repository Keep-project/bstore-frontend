// ignore_for_file: avoid_print

import 'package:bstore/components/custom_button.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/book_form/book_form.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookFormScreen extends GetView<BookFormScreenController> {
  const BookFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            Get.arguments != null ? "Editer le livre" : "Ajouter un livre",
            style: const TextStyle(
              color: kDarkColor90,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          leading: Container(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: GestureDetector(
                onTap: () {
                  if (Get.arguments != null) {
                    Get.offAndToNamed(AppRoutes.DETAILS,
                        arguments: controller.livre.id!);
                  } else {
                    Get.offAndToNamed(AppRoutes.DASHBORD);
                  }
                },
                child: const Icon(CupertinoIcons.arrow_left,
                    color: kDarkColor90, size: 30)),
          ),
        ),
        body: GetBuilder<BookFormScreenController>(builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  const SizedBox(height: kDefaultPadding),
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                          color: kWhiteColor,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 1.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Container(
                                height: Get.height * 0.60,
                                width: double.infinity,
                                decoration: const BoxDecoration(),
                                child: PageView.builder(
                                  physics: Get.arguments == null
                                      ? const NeverScrollableScrollPhysics()
                                      : const AlwaysScrollableScrollPhysics(),
                                  onPageChanged: (value) {
                                    // controller.onChangePage(value);
                                  },
                                  itemCount: controller.pages.length,
                                  controller: controller.pageController,
                                  itemBuilder: (context, index) =>
                                      controller.pages[index],
                                ),
                              ),
                              Get.arguments == null &&
                                      controller.bookStatus !=
                                          LoadingStatus.searching
                                  ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        controller.step != 1 ? Expanded(
                                          flex: 2,
                                          child: InkWell(
                                            onTap: () {
                                              controller.previousPage();
                                          },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(" Retour", textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ) : Container(),
                                        Expanded(
                                          flex: 2,
                                          child: CustomButton(
                                            title: controller.step == 3
                                                ? "Créer le livre"
                                                : "Suivant",
                                            onTap: () async {
                                              switch (controller.step) {
                                                case 1:
                                                  controller
                                                    .jumpToStepTwo(context);
                                                  break;
                                                case 2:
                                                  controller
                                                    .jumpToStepThree(context);
                                                  break;
                                                case 3:
                                                  await controller
                                                    .saveBook(context);
                                                  break;
                                                default:
                                                  break;
                                              }
                                            },
                                          ),
                                        ),
                                        
                                      ],
                                    )
                                  : Get.arguments != null &&
                                          controller.bookStatus !=
                                              LoadingStatus.searching
                                      ? CustomButton(
                                          title: "Mettre à jour",
                                          onTap: () async {
                                            await controller.editBook(context);
                                          },
                                        )
                                      : Container(
                                          height: 45,
                                          width: double.infinity,
                                          decoration: const BoxDecoration(),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: kOrangeColor,
                                            ),
                                          ),
                                        ),
                              const Spacer(flex: 2),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

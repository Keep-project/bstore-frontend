// ignore_for_file: avoid_print

import 'package:bstore/components/custom_button.dart';
import 'package:bstore/components/custom_dropdown_button.dart';
import 'package:bstore/components/custom_text_field.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
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
        body: GetBuilder<BookFormScreenController>(builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Logo",
                      style: TextStyle(
                        color: kDarkColor86,
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        color: kWhiteColor,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 1.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Ajouter un livre",
                              style: TextStyle(
                                color: kDarkColor86,
                                fontWeight: FontWeight.w900,
                                fontSize: 26,
                              ),
                            ),

                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: controller.textEditingTitre,
                              hintText: "Entrez le titre du livre",
                              helpText: "Titre du livre",
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: controller.textEditingDescription,
                              hintText: "Entrez la description",
                              helpText: "Description",
                              minLines: 4,
                              maxLines: 10,
                            ),
                            const SizedBox(height: kDefaultPadding),
                            CustomDropDown(
                              helpText: "Catégorie",
                              controller: controller,
                              liste: controller.categories,
                              selectedItem: controller.selectedCategory,
                              onChanged: (data) {
                                controller.onChangeCategory(data);
                              },
                            ),
                            const SizedBox(height: kDefaultPadding),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropDown(
                                    helpText: "Langue",
                                    controller: controller,
                                    liste: controller.langues,
                                    selectedItem: controller.selectedLanguage,
                                    onChanged: (data) {
                                      controller.onChangeLanguage(data);
                                    },
                                  ),
                                ),
                                const SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: CustomTextField(
                                    controller: controller.textEditingNombrePage,
                                    hintText: "Nombre de page",
                                    helpText: "Pages",
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: kDefaultPadding),
                            CustomTextField(
                              controller: controller.textEditingAuteur,
                              hintText: "Entrez le nom de l'auteur",
                              helpText: "Auteur",
                            ),
                            const SizedBox(height: kDefaultPadding),
                            CustomTextField(
                              controller: controller.textEditingEditeur,
                              hintText: "Entrez le nom de l'editeur",
                              helpText: "Editeur",
                            ),
                            const SizedBox(height: kDefaultPadding),
                            InkWell(
                               onTap: () async {
                                await controller.chooseImage();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(.02),
                                  border: Border.all(
                                    width: 1.2,
                                    color: kOrangeColor39.withOpacity(0.42),
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Expanded(
                                      child: Opacity(
                                          opacity: 0.6,
                                          child: Text("Photo de couverture")),
                                    ),
                                    Icon(Icons.camera_alt,
                                        color: kDarkColor86, size: 30),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            InkWell(
                              onTap: () async {
                                print("Choose document");
                                controller.getFile();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(.02),
                                  border: Border.all(
                                    width: 1.2,
                                    color: kOrangeColor39.withOpacity(0.42),
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Expanded(
                                      child: Opacity(
                                          opacity: 0.6,
                                          child: Text("Choisir le livre")),
                                    ),
                                    Icon(Icons.document_scanner,
                                        color: kDarkColor86, size: 30),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            InkWell(
                              onTap: () async {
                                DateTime? newdate = await showDatePicker(
                                  context: context,
                                  initialDate: controller.datePub,
                                  firstDate:
                                      DateTime(controller.datePub.year - 10),
                                  lastDate:
                                      DateTime(controller.datePub.year + 10),
                                );
                                if (newdate == null) {
                                  return;
                                }
                                controller.datePubToString =
                                    "${newdate.day.toString().padLeft(2, '0')}/${newdate.month.toString().padLeft(2, '0')}/${newdate.year}";
                                controller.datePub = newdate;
                                // controller.saveButtonvisible.value =
                                //     true;
                                controller.update();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(.02),
                                  border: Border.all(
                                    width: 1.2,
                                    color: kOrangeColor39.withOpacity(0.42),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Opacity(
                                          opacity: 0.6,
                                          child: Text("Date de publication ${controller.datePubToString}")),
                                    ),
                                    const Icon(Icons.calendar_month,
                                        color: kDarkColor86, size: 30),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            Text("Date de publication ${controller.datePubToString}", 
                              style: const TextStyle(
                                color: kDarkColor86,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding * 3),
                            CustomButton(
                              onTap: () async {
                                await controller.saveBook();
                              },
                            ),

                            // const Spacer(),
                          ],
                        ),
                      )),
                  // const Spacer(flex: 2),
                  const SizedBox(height: kDefaultPadding * 3),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

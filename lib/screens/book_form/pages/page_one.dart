import 'package:bstore/components/custom_dropdown_button.dart';
import 'package:bstore/components/custom_text_field.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/book_form/book_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormOneScreen extends GetView<BookFormScreenController> {
  const FormOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookFormScreenController>(builder: (controller) {
      return Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            CustomTextField(
              controller: controller.textEditingTitre,
              hintText: "Entrez le titre du livre",
              helpText: "Titre du livre",
            ),
            const SizedBox(height: 20),
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
            CustomTextField(
              controller: controller.textEditingDescription,
              hintText: "Entrez la description",
              helpText: "Description",
              minLines: 4,
              maxLines: 4,
            ),
            
          ],
        ),
      );
    });
  }
}

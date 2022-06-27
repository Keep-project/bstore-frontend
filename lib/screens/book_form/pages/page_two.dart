import 'package:bstore/components/custom_dropdown_button.dart';
import 'package:bstore/components/custom_text_field.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/book_form/book_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormTwoScreen extends GetView<BookFormScreenController> {
  const FormTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookFormScreenController>(builder: (controller) {
      return Column(
        children: [
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
                  textInputType: TextInputType.number,
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
        ],
      );
    });
  }
}

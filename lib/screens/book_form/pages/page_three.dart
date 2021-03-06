import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/book_form/book_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormThreeScreen extends GetView<BookFormScreenController> {
  const FormThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookFormScreenController>(builder: (controller) {
      return Column(
        children: [
          const SizedBox(height: kDefaultPadding),
          InkWell(
            onTap: () async {
              await controller.chooseImage();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        opacity: 0.6, child: Text("Photo de couverture")),
                  ),
                  Icon(Icons.camera_alt, color: kDarkColor86, size: 30),
                ],
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          controller.showInputFile ? InkWell(
            onTap: () async {
              controller.getFile();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child:
                        Opacity(opacity: 0.6, child: Text("Choisir le livre")),
                  ),
                  Icon(Icons.document_scanner, color: kDarkColor86, size: 30),
                ],
              ),
            ),
          ): Container(),
          const SizedBox(height: kDefaultPadding),
          InkWell(
            onTap: () async {
              DateTime? newdate = await showDatePicker(
                context: context,
                initialDate: controller.datePub,
                firstDate: DateTime(controller.datePub.year - 10),
                lastDate: DateTime(controller.datePub.year + 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        child: Text(
                            "Date de publication ${controller.datePubToString}")),
                  ),
                  const Icon(Icons.calendar_month,
                      color: kDarkColor86, size: 30),
                ],
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding),
        ],
      );
    });
  }
}

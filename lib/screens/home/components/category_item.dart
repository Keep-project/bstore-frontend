import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/models/response_data_model.dart/category_model.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
            right: kDefaultPadding - 4, bottom: kDefaultPadding),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 10),
              blurRadius: 20,
              color: kOrangeColor.withOpacity(0.09),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.SEARCH, arguments: {'id': 'categorie', 'message': 'Catégorie "${category.libelle!}"', 'pk': category.id!});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 1.5, vertical: 8),
            child: Text(
              category.libelle!.toString().capitalizeFirst!,
              style: const TextStyle(
                color: kOrangeColor,
                fontSize: 14,
              ),
            ),
          ),
        ));
  }
}

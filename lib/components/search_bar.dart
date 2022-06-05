import 'package:bstore/core/app_colors.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final double? iconSize;
  final TextEditingController controller;
  const SearchBar({
    Key? key, this.contentPadding, this.iconSize, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGreyColor85,
         boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 30,
            color: Colors.white.withOpacity(0.1),
          )
        ],
        borderRadius: BorderRadius.circular(25)
      ),
      child: TextField(
        controller: controller,
        autofocus: false,
        style: TextStyle(
          fontSize: 16,
          color: kDarkColor86.withOpacity(0.8),
        ),
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: (){
              if (controller.text.trim().isEmpty){
                controller.text = "Le champ ne peut être vide";
                Future.delayed(const Duration(seconds: 2), () {
                  controller.clear();
                });
                return;
              }
              Get.toNamed(AppRoutes.SEARCH, arguments: {'id': 'search','message': 'Resultat pour "${controller.text.trim()}"'});
            },
            child: Icon(CupertinoIcons.search, size: iconSize ?? 36, color: kOrangeColor)),
          hintText: "Rechercher un livre ...",
          contentPadding: contentPadding ?? const EdgeInsets.all(16),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: TextStyle(
          color: kDarkColor86.withOpacity(0.5),
          fontSize: 16,
        ),
        ),
      ),
    );
  }
}
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final double? iconSize;
  const SearchBar({
    Key? key, this.contentPadding, this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
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
        autofocus: false,
        style: TextStyle(
          fontSize: 16,
          color: kOrangeColor.withOpacity(0.8),
        ),
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: (){Get.toNamed(AppRoutes.SEARCH);},
            child: Icon(CupertinoIcons.search, size: iconSize ?? 36, color: kOrangeColor)),
          hintText: "Rechercher un livre ...",
          contentPadding: contentPadding ?? const EdgeInsets.all(16),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: TextStyle(
          color: kOrangeColor.withOpacity(0.5),
          fontSize: 16,
        ),
        ),
      ),
    );
  }
}
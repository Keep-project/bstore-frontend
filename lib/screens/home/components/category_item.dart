

import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String? title;
  const CategoryItem({
    Key? key, required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: kDefaultPadding - 4, bottom: kDefaultPadding),
      decoration:  BoxDecoration(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*1.5, vertical: 8),
        child: Text(title!, 
          style: const TextStyle(
            color: kOrangeColor,
            fontSize: 18,
          ),
        ),
      )
    );
  }
}




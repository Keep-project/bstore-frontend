
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  const CustomButton({
    Key? key, required this.onTap, required this.title,
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
        child: Center(
          child: Text(title!,
            style: const TextStyle(
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
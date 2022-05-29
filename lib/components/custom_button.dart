
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  const CustomButton({
    Key? key, required this.onTap,
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
        child: const Center(
          child: Text("Enregistrer",
            style: TextStyle(
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
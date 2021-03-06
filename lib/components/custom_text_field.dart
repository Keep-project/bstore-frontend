
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? helpText;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final TextInputType? textInputType;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.helpText, this.controller, this.maxLines, this.minLines,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.6,
          child: Text(
            "$helpText",
            style: const TextStyle(
              fontSize: 16,
              color: kDarkColor90,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.02),
              border:Border.all(
                width: 1.2,
                color: kOrangeColor39.withOpacity(0.42),
              ),
              borderRadius: BorderRadius.circular(8)),
          child: TextField(
            minLines: minLines ?? 1,
            maxLines: maxLines ?? 1,
            controller: controller!,
            keyboardType:  textInputType ?? TextInputType.text,
            style: const TextStyle(
              fontSize: 16,
              color: kDarkColor90,
            ),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.only(
                  left: kDefaultPadding / 2,
                  top: kDefaultPadding / 4,
                  right: kDefaultPadding / 2,
                  bottom: kDefaultPadding / 4),
              hintText: '$hintText',
              hintStyle: TextStyle(
                fontSize: 12,
                color: kDarkColor90.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:bstore/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconData extends StatelessWidget {
  final String? value;
  final IconData? iconData;
  final double? size;
  final Color? color;
  const CustomIconData({
    Key? key,
    this.value,
    this.iconData,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(iconData!,
              size: size!, color: color ?? kDarkColor86.withOpacity(0.6)),
        ),
        Text(value!,
            style: TextStyle(
                color: kDarkColor86.withOpacity(0.7),
                fontSize: 22,
                fontWeight: FontWeight.w900)),
      ],
    );
  }
}

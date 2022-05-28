

import 'package:bstore/core/app_colors.dart';
import 'package:flutter/material.dart';
class IconAndLabel extends StatelessWidget {
  final String? libelle;
  final IconData iconData;
  final double? size;
  const IconAndLabel(
      {Key? key, this.libelle, required this.iconData, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconData,
          size: size ?? 22,
          color: kDarkColor86,
        ),
        Text(
          libelle!,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: kWhiteColor,
          ),
        ),
      ],
    );
  }
}

import 'package:bstore/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomCard extends StatelessWidget {
  final IconData? iconData;
  final int? number;
  final String? libelle;
  const CustomCard({
    Key? key, this.iconData, this.number, this.libelle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: Get.width / 2 - 32,
        decoration: BoxDecoration(
          color: kOrangeColor39.withOpacity(0.72),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  Text(
                    "$number",
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Icon(iconData!, color: kOrangeColor, size: 30)
                ]),
                 Text(
                    "$libelle",
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
          ],
        ));
  }
}
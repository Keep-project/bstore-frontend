import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding - 4),
      height: 45,
      child: Row(children: <Widget>[
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(CupertinoIcons.arrow_left,
                size: 26, color: kWhiteColor)),
      ]),
    );
  }
}
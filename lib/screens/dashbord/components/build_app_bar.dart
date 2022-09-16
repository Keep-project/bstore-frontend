import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildAppBar extends StatelessWidget {
  final dynamic controller;
  const BuildAppBar({
    Key? key, this.controller,
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
        const Spacer(),
        InkWell(
          onTap: () async { await controller.deleteToken(); },
          child: Row(
            children: const [
            Text("Déconnexion", style: TextStyle(
              color: kWhiteColor,
              fontSize: 14,
            )),
            SizedBox(width: 5),
            Icon(Icons.power,
                      size: 26, color: kWhiteColor),
            SizedBox(width: 5),
            ],
          ),
        ),
      ]),
    );
  }
}

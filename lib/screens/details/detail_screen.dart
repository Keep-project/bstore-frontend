import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Container(
                height: Get.height * 0.6,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: kOrangeColor.withOpacity(.1),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding-4),
                      decoration: const BoxDecoration(
                        color: kWhiteColor,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){Get.back();},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(CupertinoIcons.arrow_left, color: kDarkColor90, size: 26),
                            )),
                          const Spacer(),
                          const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(CupertinoIcons.person_fill, color: kDarkColor90, size: 26),
                            ),
                            const SizedBox(width: 5,),
                          const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.more_vert, color: kDarkColor90, size: 26),
                            ),
                        ]
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
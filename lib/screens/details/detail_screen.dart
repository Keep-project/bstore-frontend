// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/popular_book_item.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/details/components/icon_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: Get.height * 0.63,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: Get.height * 0.63,
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        Opacity(
                          opacity: 0.0915,
                          child: Container(
                            height: Get.height * 0.63 - 30,
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/femme-de-pouvoir.jpg"),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          right: Get.height * 0.185,
                          left: Get.height * 0.185,
                          child: Container(
                            height: 220,
                            width: 200,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/femme-de-pouvoir.jpg"),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 285,
                          right: 0,
                          left: 0,
                          child: Column(children: [
                            const Text(
                              "Leurs figures",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Opacity(
                              opacity: 0.6,
                              child: Text(
                                "Jacques Verges",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CustomIconData(
                                    color: kOrangeColor,
                                    size: 26,
                                    iconData: CupertinoIcons.heart_fill,
                                    value: "100"),
                              ],
                            ),
                          ]),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: kDefaultMargin * 3,
                                right: kDefaultMargin * 3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding / 2),
                            decoration: BoxDecoration(
                              color: kOrangeColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                IconAndLabel(
                                    iconData: Icons.language,
                                    libelle: "Français"),
                                IconAndLabel(
                                    iconData: CupertinoIcons.book_fill,
                                    libelle: "120 pages"),
                                IconAndLabel(
                                    iconData: CupertinoIcons.chat_bubble_2_fill,
                                    libelle: "10",
                                    size: 30),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const HeadTitle(title: "Description"),
                    const SizedBox(height: kDefaultPadding - 4),
                    Text(
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Officia placeat beatae deleniti perferendis laboriosam modi.Architecto ad itaque quidem odio fugiat quia odit perferendis iure incidunt, numquam, tempore, natus similique!",
                      style: TextStyle(
                        color: kDarkColor86.withOpacity(0.7),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          width: Get.width / 2 - 32,
                          decoration: BoxDecoration(
                            color: kOrangeColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "1.1M ",
                                    style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                   TextSpan(
                                    text: "Téléchargements ",
                                    style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: Get.width / 2 - 32,
                          decoration: BoxDecoration(
                            color: kGreenColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                               Text("Télécharger",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    // fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(CupertinoIcons.cloud_download_fill, color: kWhiteColor, size: 26)
                            ]
                          ),
                        ),

                      ]
                    ),
                    const SizedBox(height: 30),
                    Row(children: [
                      const HeadTitle(
                        title: "Livres similaires",
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.SEARCH);
                          },
                          child: const Opacity(
                            opacity: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Text("Voir plus",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkColor86,
                                  )),
                            ),
                          )),
                    ]),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const <Widget>[
                          BookItem(),
                          BookItem(),
                          BookItem(),
                          BookItem(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(CupertinoIcons.arrow_left,
            color: kDarkColor90, size: 26),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.DASHBORD);
            },
            child: const Icon(CupertinoIcons.person_fill,
                color: kDarkColor90, size: 26),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.more_vert, color: kDarkColor90, size: 26),
        )
      ],
    );
  }
}

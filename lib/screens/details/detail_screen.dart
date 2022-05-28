// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/head_title.dart';
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
                // width: double.infinity,
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
                    const SizedBox(height: 30),
                    Row(children: [
                      const HeadTitle(
                        title: "Livres similaires",
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            print("Voir plus");
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
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Icon(CupertinoIcons.person_fill, color: kDarkColor90, size: 26),
        ),
        SizedBox(
          width: 5,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.more_vert, color: kDarkColor90, size: 26),
        )
      ],
    );
  }
}

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
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

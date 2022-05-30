// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/popular_book_item.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/dashbord/components/background_color.dart';
import 'package:bstore/screens/dashbord/components/custom_card.dart';
import 'package:bstore/screens/dashbord/components/profil_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              height: Get.height,
              color: kBlueDark,
            ),
            const ProfilSection(),
            const BackgrounColor(),
            Positioned(
              top: 230,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomCard(
                              number: 24,
                              iconData: CupertinoIcons.cloud_download,
                              libelle: "Téléchargements"),
                          CustomCard(
                              number: 35,
                              iconData: CupertinoIcons.cloud_upload,
                              libelle: "Publications"),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultMargin * 3,
                      ),
                      const HeadTitle(title: "Mes favoris"),
                      const SizedBox(
                        height: kDefaultPadding - 4,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            ...List.generate(50, (index) => Stack(
                              children: <Widget> [
                                const BookItem(),
                                Positioned(
                                  top: kDefaultMargin /1.5,
                                  right: kDefaultMargin *2.5,
                                  child: InkWell(
                                    onTap: () {print("Télécharger");},
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 8),
                                            blurRadius: 8,
                                            color: kGreenColor.withOpacity(0.2)
                                          ),
                                        ]
                                      ),
                                      child: const Center(
                                        child: Icon(CupertinoIcons.arrow_down_to_line, color: kGreenColor, size: 26)
                                      ),
                                    ),
                                  )
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultMargin * 2.6,
                      ),
                      const HeadTitle(title: "Mes téléchargement"),
                      const SizedBox(
                        height: kDefaultPadding - 4,
                      ),
                      ...List.generate(
                        25,
                        (index) => Stack(
                          clipBehavior: Clip.none,
                          children:  [
                            const PopularBookItem(
                                margin:
                                    EdgeInsets.only(bottom: kDefaultMargin * 1.8)),
                            Positioned(
                                  top: -10,
                                  right: kDefaultMargin *1.92,
                                  child: InkWell(
                                    onTap: () {print("Télécharger");},
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 8),
                                            blurRadius: 8,
                                            color: kGreenColor.withOpacity(0.2)
                                          ),
                                        ]
                                      ),
                                      child: const Center(
                                        child: Icon(CupertinoIcons.arrow_down_to_line, color: kGreenColor, size: 26)
                                      ),
                                    ),
                                  )
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                            libelle: "Téléchargements"
                          ),
                          CustomCard(
                            number: 35,
                            iconData: CupertinoIcons.cloud_upload,
                            libelle: "Publications"
                          ),
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
                          children: const <Widget>[
                            BookItem(),
                            BookItem(),
                            BookItem(),
                            BookItem(),
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
                      const PopularBookItem(
                          margin:
                              EdgeInsets.only(bottom: kDefaultMargin * 1.8)),
                      const PopularBookItem(
                          margin:
                              EdgeInsets.only(bottom: kDefaultMargin * 1.8)),
                      const PopularBookItem(
                          margin:
                              EdgeInsets.only(bottom: kDefaultMargin * 1.8)),
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






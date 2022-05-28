// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/search_bar.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BuildAppBar(),
                const SizedBox(height: kDefaultMargin * 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 1.5),
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: "Livres similaires ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor,
                      ),
                    ),
                    TextSpan(
                      text: "(12)",
                      style: TextStyle(
                        fontSize: 16,
                        color: kWhiteColor,
                      ),
                    ),
                  ])),
                ),
                const SizedBox(height: kDefaultMargin * 2.5),
              ],
            ),
            Positioned(
              top: 190,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultRadius * 4),
                    // topRight: Radius.circular(kDefaultRadius * 4),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding,),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: 20,
                  shrinkWrap: true,
                  childAspectRatio: 0.69,
                  children: <Widget>[
                    ...List.generate(
                        60,
                        (index) => const BookItem(
                              width: 300,
                              marginRight: 2,
                            )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        const SizedBox(width: 5),
        const Expanded(
            child: SearchBar(
          iconSize: 26,
          contentPadding: EdgeInsets.only(
              left: kDefaultPadding - 4, right: 10, top: kDefaultPadding / 1.9),
        )),
        const SizedBox(width: 5),
        IconButton(
            onPressed: () {
              print("Navigate to profil page");
            },
            icon: const Icon(CupertinoIcons.person_fill,
                size: 26, color: kWhiteColor)),
      ]),
    );
  }
}

// Container(
//   margin: const EdgeInsets.only(top: 50),
//   width: double.infinity,
//   padding: const EdgeInsets.all(kDefaultPadding),
//   decoration: const BoxDecoration(
//     color: kWhiteColor,
//     borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(kDefaultRadius * 4),
//       topRight: Radius.circular(kDefaultRadius * 4),
//     ),
//   ),
//   // child: const Text(""),
// ),
// Container(
//   padding: const EdgeInsets.all(kDefaultPadding),
//   child: Column(
//     children: const [
//       BookItem(),
//       BookItem(),
//       BookItem(),
//       BookItem(),
//       BookItem(),
//       BookItem(),
//       BookItem(),
//       BookItem(),
//     ],
//   ),
// ),


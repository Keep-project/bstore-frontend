// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/popular_book_item.dart';
import 'package:bstore/components/search_bar.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/home/components/category_item.dart';
import 'package:bstore/screens/home/components/home_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                padding: const EdgeInsets.all(0),
                height: Get.height,
                child: Column(
                  children: <Widget>[
                    const HomeBanner(),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: SearchBar(),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: HeadTitle(
                                          title: "Explorer par thèmes"),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: const <Widget>[
                                            CategoryItem(title: "Histoire"),
                                            CategoryItem(title: "Geographie"),
                                            CategoryItem(title: "Philosophie"),
                                            CategoryItem(title: "Romans"),
                                            CategoryItem(title: "Politique"),
                                            CategoryItem(title: "Economie"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: Row(children: [
                                        const HeadTitle(
                                          title: "Livres récents",
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
                                                    horizontal: 8.0,
                                                    vertical: 4),
                                                child: Text("Voir plus",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kDarkColor86,
                                                    )),
                                              ),
                                            )),
                                      ]),
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: SingleChildScrollView(
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
                                    ),
                                    const SizedBox(height: 20),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: HeadTitle(
                                        title: "Plus populaires",
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const PopularBookItem(),
                                    const PopularBookItem(),
                                    const PopularBookItem(),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}



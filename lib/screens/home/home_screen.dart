// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/popular_book_item.dart';
import 'package:bstore/components/search_bar.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/home/components/category_item.dart';
import 'package:bstore/screens/home/components/home_banner.dart';
import 'package:bstore/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: GetBuilder<HomeScreenController>(
              builder: (controller) {
                return Container(
                    padding: const EdgeInsets.all(0),
                    height: Get.height,
                    child: Column(
                      children: <Widget>[
                        const HomeBanner(),
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                child: SearchBar(controller: controller.searchTextEditingController),
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
                                        controller.categoriesListStatus == LoadingStatus.searching ?
                                        Container(
                                          height: 60,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(0),
                                          child: const Center(
                                            child: CircularProgressIndicator(color: kOrangeColor),
                                          ),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: kDefaultPadding),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[

                                                ...List.generate(
                                                  controller.listCategories.length,
                                                  (index) => CategoryItem(category: controller.listCategories[index]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: kDefaultPadding),
                                          child: Row(children: [
                                            Row(
                                              children: [
                                                const HeadTitle(
                                                  title: "Livres récents",
                                                ),
                                                Text("(${controller.listLivre.length.toString().padLeft(2, '0')})"),
                                              ],
                                            ),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  Get.toNamed(AppRoutes.SEARCH, arguments: {'id': 'liste', 'message': "Liste des livres"});
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
                                        controller.recentBookStatus == LoadingStatus.searching ?
                                        Container(
                                          height: 155,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(0),
                                          child: const Center(
                                            child: CircularProgressIndicator(color: kOrangeColor),
                                          ),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: kDefaultPadding),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
                                                ...List.generate(
                                                  controller.listLivre.length, 
                                                (index) => BookItem(
                                                  onTap: ()async{ await controller.likeBook(index);},
                                                  controller: controller,
                                                  livre: controller.listLivre[index],
                                                ),)
                                                
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

                                        controller.popularListStatus == LoadingStatus.searching ?
                                        Container(
                                          height: 155,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(0),
                                          child: const Center(
                                            child: CircularProgressIndicator(color: kOrangeColor),
                                          ),
                                        )
                                        : SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              ...List.generate(
                                                controller.popularLivreBooks.length, 
                                              (index) => PopularBookItem(
                                                livre: controller.popularLivreBooks[index],
                                                onTap: ()async{ await controller.likePopularBook(index);},
                                                
                                              ),)
                                              
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              }
            )));
  }
}



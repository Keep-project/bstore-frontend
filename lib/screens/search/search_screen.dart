// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/search_bar.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SearchController>(builder: (controller) {
        return Scaffold(
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
                  const SizedBox(height: kDefaultMargin * 3.4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "${Get.arguments['message']} ",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: kWhiteColor,
                        ),
                      ),
                      controller.idPage == "liste"
                          ? TextSpan(
                              text:
                                  "(${controller.listLivre.length.toString().padLeft(2, '0')})",
                              style: const TextStyle(
                                fontSize: 16,
                                color: kWhiteColor,
                              ),
                            )
                          : const TextSpan(),
                    ])),
                  ),
                  const SizedBox(height: kDefaultMargin * 2.5),
                ],
              ),
              Positioned(
                top: 140,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultRadius * 4),
                    ),
                  ),
                ),
              ),
              controller.searchStatus == LoadingStatus.searching
                  ? Positioned(
                      top: 165,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(color: kOrangeColor),
                        ),
                      ))
                  : Positioned(
                      top: 165,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: controller.infinityStatus ==
                              LoadingStatus.searching && controller.idPage != 'liste'
                          ? Container(
                              padding: const EdgeInsets.all(0),
                              height: 100,
                              width: double.infinity,
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: kDarkColor86),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(
                                left: kDefaultPadding,
                                right: kDefaultPadding,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: GridView.count(
                                controller: controller.scrollController,
                                crossAxisCount: 2,
                                mainAxisSpacing: kDefaultPadding,
                                crossAxisSpacing: 20,
                                shrinkWrap: true,
                                childAspectRatio: 0.69,
                                children: <Widget>[
                                  ...List.generate(
                                      controller.listLivre.length,
                                      (index) => BookItem(
                                          width: 300,
                                          marginRight: 2,
                                          onTap: () async {
                                            await controller.likeBook(index);
                                          },
                                          controller: controller,
                                          livre: controller.listLivre[index])),
                                    controller.infinityStatus == LoadingStatus.searching ? Container(
                                      padding: const EdgeInsets.all(0),
                                      height: 100,
                                      width: double.infinity,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                            color: kOrangeColor),
                                      ),
                                    ): Container(),
                                ],
                              ),
                            ),
                    ),
              controller.listLivre.isEmpty && controller.searchStatus == LoadingStatus.completed
                  ? Positioned(
                      top: 165,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Ooops !!!\nAucun livre trouvé",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kDarkColor86.withOpacity(0.4),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ))
                  : Container(height: 0),
            ],
          ),
        );
      }),
    );
  }
}

class BuildAppBar extends GetView<SearchController> {
  const BuildAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(builder: (controller) {
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
          Expanded(
              child: SearchBar(
            controller: controller.searchTextEditingController,
            iconSize: 26,
            contentPadding: const EdgeInsets.only(
                left: kDefaultPadding - 4,
                right: 10,
                top: kDefaultPadding / 1.9),
          )),
          const SizedBox(width: 5),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.DASHBORD);
              },
              icon: const Icon(CupertinoIcons.person_fill,
                  size: 26, color: kWhiteColor)),
        ]),
      );
    });
  }
}

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
                        text: "${ controller.message } ",
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
                        height: Get.height,
                       
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
                              LoadingStatus.searching 
                              //&& controller.idPage != 'liste' 
                              && controller.idPage != 'search'
                              && controller.listLivre.isEmpty
                          ? Container(
                              padding: const EdgeInsets.all(0),
                              height: 100,
                              width: double.infinity,
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: kOrangeColor),
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
                              child: SingleChildScrollView(
                                controller: controller.scrollController,
                                  child: Wrap(
                                    spacing: kDefaultPadding + 6,
                                    runSpacing: 20,
                                    crossAxisAlignment: WrapCrossAlignment.center ,
                                    children: <Widget>[
                                    ...List.generate(
                                        controller.listLivre.length,
                                        (index) => BookItem(
                                            width: (Get.width - 70) / 2,
                                            marginRight: 2,
                                            onTap: () async {
                                              await controller.likeBook(index);
                                            },
                                            onPress: (){
                                              Get.toNamed(AppRoutes.DETAILS, arguments: controller.listLivre[index].id!);
                                            },
                                            controller: controller,
                                            livre: controller.listLivre[index])),
                                      controller.infinityStatus == LoadingStatus.searching ? Container(
                                        padding: const EdgeInsets.all(0),
                                        height: 150,
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
                    ),
              (controller.listLivre.isEmpty 
              && controller.searchStatus == LoadingStatus.completed) ||
              (controller.listLivre.isEmpty 
              && controller.infinityStatus == LoadingStatus.completed) 
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
                onTap: () async {
                  await controller.filterBooks();
                },
            controller: controller.searchTextEditingController,
            iconSize: 26,
            contentPadding: const EdgeInsets.only(
                left: kDefaultPadding - 4,
                right: 10,
                top: kDefaultPadding / 1.9),
          )),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Get.offNamed(AppRoutes.DASHBORD);
            },
            child: controller.avatar == ""
                ? const Icon(CupertinoIcons.person_fill,
                    color: kDarkColor90, size: 26)
                : Container(
                    height: 35,
                    width: 35,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(controller.avatar, fit: BoxFit.fill))),
            
          // IconButton(
          //     onPressed: () {
          //       Get.toNamed(AppRoutes.DASHBORD);
          //     },
          //     icon: const Icon(CupertinoIcons.person_fill,
          //         size: 26, color: kWhiteColor)),
        ]),
      );
    });
  }
}

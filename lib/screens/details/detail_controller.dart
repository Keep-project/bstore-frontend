import 'package:bstore/core/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DetailScreenController extends GetxController {
  final PageController pageController = PageController();
  int currentIndexPage = 0;
  bool showComments = false;
  final List<Text> comments = <Text>[
    Text(
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Officia placeat beatae deleniti perferendis laboriosam modi.Architecto ad itaque quidem odio fugiat quia odit perferendis iure incidunt, numquam, tempore, natus similique!",
      style: TextStyle(
        color: kDarkColor86.withOpacity(0.7),
        fontSize: 15,
        height: 1.5,
      ),
    ),
    Text(
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Officia placeat beatae deleniti perferendis laboriosam modi.Architecto ad itaque quidem odio fugiat quia odit perferendis iure incidunt, numquam, tempore, natus similique!",
      style: TextStyle(
        color: kDarkColor86.withOpacity(0.7),
        fontSize: 15,
        height: 1.5,
      ),
    ),
    Text(
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Officia placeat beatae deleniti perferendis laboriosam modi.Architecto ad itaque quidem odio fugiat quia odit perferendis iure incidunt, numquam, tempore, natus similique!",
      style: TextStyle(
        color: kDarkColor86.withOpacity(0.7),
        fontSize: 15,
        height: 1.5,
      ),
    ),
    Text(
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Officia placeat beatae deleniti perferendis laboriosam modi.Architecto ad itaque quidem odio fugiat quia odit perferendis iure incidunt, numquam, tempore, natus similique!",
      style: TextStyle(
        color: kDarkColor86.withOpacity(0.7),
        fontSize: 15,
        height: 1.5,
      ),
    ),
  ];

  void onNextChangedPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }

  void onPreviousChangedPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }

  void onChangePage(int value) {
    currentIndexPage = value;
    update();
  }
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}

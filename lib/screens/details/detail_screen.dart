// ignore_for_file: avoid_print

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/custom_text_field.dart';
import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/popular_book_item.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/details/components/icon_label.dart';
import 'package:bstore/screens/details/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class DetailScreen extends GetView<DetailScreenController> {
  const DetailScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailScreenController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildAppBar(controller),
          body: SingleChildScrollView(
            child: controller.loadingStatus == LoadingStatus.searching
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    padding: const EdgeInsets.all(20),
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Colors.red,
                    )),
                  )
                : Column(
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
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            controller.livre.image!),
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
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            controller.livre.image!),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 285,
                                  right: 0,
                                  left: 0,
                                  child: Column(children: [
                                    Text(
                                      controller.livre.titre!
                                          .toString()
                                          .capitalizeFirst!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.6,
                                      child: Text(
                                        controller.livre.auteur!.toString().capitalizeFirst!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomIconData(
                                            onTap: () async {
                                              await controller.likeBook(-1);
                                            },
                                            color: kOrangeColor,
                                            size: 26,
                                            iconData: controller.is_like
                                                ? CupertinoIcons.heart_fill
                                                : CupertinoIcons.heart,
                                            value: controller.livre.likes!
                                                .toString()),
                                             
                                        controller.userId == controller.livre.proprietaire! ? Row(
                                          children: [
                                             const  SizedBox(width: kDefaultPadding/2),
                                            GestureDetector(
                                              onTap: () {
                                                Get.offAndToNamed(AppRoutes.BOOKFORM, arguments: controller.livre);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(.2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(Icons.edit, size: 20, color: kDarkColor90),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ) :  Container(),
                                        
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndLabel(
                                            iconData: Icons.language,
                                            libelle: controller.livre.langue!
                                                .toString()),
                                        IconAndLabel(
                                            iconData: CupertinoIcons.book_fill,
                                            libelle:
                                                "${controller.livre.nbpages!} pages"),
                                        IconAndLabel(
                                            iconData: CupertinoIcons
                                                .chat_bubble_2_fill,
                                            libelle:
                                                "${controller.livre.commentaires!.length}",
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
                              controller.livre.description!,
                              style: TextStyle(
                                color: kDarkColor86.withOpacity(0.7),
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                "${controller.livre.telecharges!} ",
                                            style: const TextStyle(
                                              color: kWhiteColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: "Téléchargements ",
                                            style: TextStyle(
                                              color: kWhiteColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await controller
                                          .downloadAndSaveFileToStorage();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: Get.width / 2 - 32,
                                      decoration: BoxDecoration(
                                        color: kGreenColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.downloadStatus ==
                                                      LoadingStatus.searching
                                                  ? "En cours..."
                                                  : "Télécharger",
                                              style: const TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            controller.downloadStatus ==
                                                    LoadingStatus.searching
                                                ? Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: const BoxDecoration(),
                                                  child: const CircularProgressIndicator(
                                                      color: kWhiteColor,
                                                      strokeWidth: 2),
                                                )
                                                : const Icon(
                                                    CupertinoIcons
                                                        .cloud_download_fill,
                                                    color: kWhiteColor,
                                                    size: 26)
                                          ]),
                                    ),
                                  ),
                                ]),
                            const SizedBox(height: 30),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                         controller.showComments =
                                            !controller.showComments;
                                        controller.update();
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                          "Avis",
                                          style: TextStyle(
                                            color: !controller.showComments
                                                ? Colors.black
                                                : Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "4.2",
                                          style: TextStyle(
                                            color: kDarkColor90.withOpacity(0.8),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        ...List.generate(
                                            4,
                                            (index) => const Icon(
                                                CupertinoIcons.star_fill,
                                                color: kOrangeColor,
                                                size: 11)),
                                          ],
                                        ),
                                    ),
                                    
                                    TextButton(
                                      onPressed: () {
                                        controller.showComments =
                                            !controller.showComments;
                                        controller.update();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          "Commenter",
                                          style: TextStyle(
                                            color: controller.showComments
                                                ? Colors.black
                                                : Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  controller.comments.isNotEmpty && !controller.showComments
                                      ? Row(children: <Widget>[
                                          IconButton(
                                              onPressed: () {
                                                controller
                                                    .onPreviousChangedPage();
                                              },
                                              padding: const EdgeInsets.all(0),
                                              icon: Icon(
                                                  CupertinoIcons.chevron_left,
                                                  color: controller
                                                              .currentIndexPage ==
                                                          0
                                                      ? kOrangeColor
                                                          .withOpacity(.4)
                                                      : kOrangeColor,
                                                  size: 20)),
                                          IconButton(
                                              onPressed: () {
                                                controller.onNextChangedPage();
                                              },
                                              padding: const EdgeInsets.all(0),
                                              icon: Icon(
                                                  CupertinoIcons
                                                      .chevron_forward,
                                                  color: controller
                                                              .currentIndexPage ==
                                                          controller.comments
                                                                  .length -
                                                              1
                                                      ? kOrangeColor
                                                          .withOpacity(.4)
                                                      : kOrangeColor,
                                                  size: 20)),
                                        ])
                                      : Container(),
                                ]),
                            controller.comments.isNotEmpty && !controller.showComments
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minHeight: 60,
                                        maxHeight: 150,
                                      ),
                                      child: Card(
                                        elevation: 0,
                                        clipBehavior: Clip.antiAlias,
                                        child: PageView.builder(
                                            onPageChanged: (value) {
                                              controller.onChangePage(value);
                                            },
                                            itemCount:
                                                controller.comments.length,
                                            controller:
                                                controller.pageController,
                                            itemBuilder: (context, index) =>
                                                controller.comments[index]),
                                      ),
                                    ),
                                  )
                                : Container(
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        hintText: "Tapez votre commentaire ici...",
                                        helpText: "",
                                        controller: controller.commentTextController,
                                        maxLines: 10,
                                        minLines: 5
                                      ),
                                      const SizedBox(
                                        height: kDefaultPadding /2
                                      ),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () async {
                                              controller.sendComment(context);
                                            },
                                            child: Container(
                                              width: 100,
                                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
                                              decoration: BoxDecoration(
                                                color: kGreenColor,
                                                borderRadius: BorderRadius.circular(kDefaultRadius/2)
                                              ),
                                              child: const Center(
                                                child: Text("Envoyer",
                                                 style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600, 
                                                 )
                                                ),
                                              ) 
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            const SizedBox(height: 30),
                            const HeadTitle(
                              title: "Livres similaires",
                            ),
                            
                            const SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  ...List.generate(
                                    controller.livresimilaires.length,
                                    (index) => 
                                    BookItem(
                                      onTap: ()async{ await controller.likeBook(index);},
                                      controller: controller,
                                      livre: controller.livresimilaires[index],
                                      onPress: () async {
                                        Get.offAndToNamed(AppRoutes.DETAILS, arguments: controller.livresimilaires[index].id, );
                                        controller.onInit();
                                      },
                                    ),
                                  )
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
    });
  }

  AppBar buildAppBar(controller) {
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
          child: GestureDetector(
              onTap: () async {
                await Share.share(
                    "${controller.livre.titre!} \n${controller.livre.description!}\nNous sommes là pour vous. Cliquez sur le lien.  \n\n${controller.livre.fichier!}");
              },
              child: const Icon(Icons.share_outlined,
                  color: kDarkColor90, size: 26)),
        ),
        const SizedBox(
          width: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.DASHBORD);
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
                    child: Image.network(controller.avatar, fit: BoxFit.fill),
                  ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

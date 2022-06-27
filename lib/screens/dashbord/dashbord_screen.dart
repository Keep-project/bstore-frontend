// ignore_for_file: avoid_print, sort_child_properties_last

import 'package:bstore/components/book_item.dart';
import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/popular_book_item.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/dashbord/components/background_color.dart';
import 'package:bstore/screens/dashbord/components/custom_card.dart';
import 'package:bstore/screens/dashbord/components/profil_section.dart';
import 'package:bstore/screens/dashbord/dashbord.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilScreen extends GetView<ProfilScreenController> {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //     Get.toNamed(AppRoutes.BOOKFORM);
        //   },
        //   child: const Icon(Icons.add, size: 36, color: kWhiteColor),
        //   backgroundColor: kDarkColor86,
        // ),
        body: GetBuilder<ProfilScreenController>(
          builder: (_) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  height: Get.height,
                  color: kBlueDark,
                ),
                ProfilSection(controller: controller),
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
                            children: [
                              CustomCard(
                                  number: controller.downloadsBooks.length,
                                  iconData: CupertinoIcons.cloud_download,
                                  libelle: "Téléchargements"),
                              CustomCard(
                                  number: controller.uploadsBooks.length,
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
                          controller.userStatus == LoadingStatus.searching ? 
                          Container(
                            decoration: const BoxDecoration(),
                              child: const Center(
                                child: CircularProgressIndicator(color:  Colors.red,),
                              )
                          ): controller.userStatus == LoadingStatus.completed ? 
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                ...List.generate(
                                  controller.likedBooks.length,
                                (index) => Stack(
                                  children: <Widget> [
                                    BookItem(
                                      controller: controller,
                                      livre: controller.likedBooks[index],
                                      onTap: () async { controller.likeBook( controller.likedBooks[index].id!,index, 'like');},
                                      onPress: (){
                                        Get.toNamed(AppRoutes.DETAILS, arguments: controller.likedBooks[index].id!);
                                      },
                                    ),
                                    
                                    Positioned(
                                      top: kDefaultMargin /1.6,
                                      right: kDefaultMargin *2.5,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await controller.downloadAndSaveFileToStorage(controller.likedBooks[index]);
                                        },
                                        child: controller.downloadStatus == LoadingStatus.searching && controller.likedBooks[index].id! == controller.selectedToDownload!.id! ?
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: const BoxDecoration(),
                                          child: const CircularProgressIndicator(color: kOrangeColor)
                                        )
                                      :Container(
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
                          ):  Container(
                            decoration: const BoxDecoration(),
                              child: const Center(
                                child: Text("No data"),
                              )
                          ),
                          const SizedBox(
                            height: kDefaultMargin * 3,
                          ),
                          const HeadTitle(title: "Mes publications"),
                          const SizedBox(
                            height: kDefaultPadding - 4,
                          ),
                          controller.userStatus == LoadingStatus.searching ? 
                          Container(
                            decoration: const BoxDecoration(),
                              child: const Center(
                                child: CircularProgressIndicator(color:  Colors.red,),
                              )
                          ): controller.userStatus == LoadingStatus.completed ? 
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                ...List.generate(
                                  controller.uploadsBooks.length,
                                (index) => Stack(
                                  children: <Widget> [
                                    BookItem(
                                      controller: controller,
                                      livre: controller.uploadsBooks[index],
                                      onTap: () async { controller.likeBook(controller.uploadsBooks[index].id!, index, 'upload');},
                                      onPress: (){
                                        Get.toNamed(AppRoutes.DETAILS, arguments: controller.uploadsBooks[index].id!);
                                      },
                                    ),
                                    
                                    Positioned(
                                      top: kDefaultMargin /1.6,
                                      right: kDefaultMargin *2.5,
                                      child: controller.downloadStatus == LoadingStatus.searching && controller.uploadsBooks[index].id! == controller.selectedToDownload!.id! ?
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: const BoxDecoration(),
                                          child: const CircularProgressIndicator(color: kOrangeColor)
                                        )
                                      : GestureDetector(
                                        onTap: () async {
                                          await controller.downloadAndSaveFileToStorage(controller.uploadsBooks[index]);
                                        },
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
                          ):  Container(
                            decoration: const BoxDecoration(),
                              child: const Center(
                                child: Text("No data"),
                              )
                          ),
                          const SizedBox(
                            height: kDefaultMargin * 2.6,
                          ),
                          HeadTitle(title: "Mes téléchargement(${controller.downloadsBooks.length})"),
                          const SizedBox(
                            height: kDefaultPadding - 4,
                          ),
                          ...List.generate(
                            controller.downloadsBooks.length,
                            (index) => Stack(
                              clipBehavior: Clip.none,
                              children:  [
                                PopularBookItem(
                                  onTap: () async{ await controller.likeBook(controller.downloadsBooks[index].id!, index, 'download');},
                                  livre: controller.downloadsBooks[index],
                                    margin:
                                       const EdgeInsets.only(bottom: kDefaultMargin * 1.8)),
                                Positioned(
                                      top: -10,
                                      right: kDefaultMargin *1.92,
                                      child: GestureDetector(
                                         onTap: () async {
                                          await controller.downloadAndSaveFileToStorage(controller.downloadsBooks[index]);
                                        },
                                        child:  controller.downloadStatus == LoadingStatus.searching && controller.downloadsBooks[index].id! == controller.selectedToDownload!.id! ?
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: const BoxDecoration(),
                                          child: const CircularProgressIndicator(color: kOrangeColor)
                                        )
                                      :   Container(
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
                          const SizedBox(height: kDefaultPadding*3.2)
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 20,
                            color: kDarkColor90.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){Get.offAndToNamed(AppRoutes.HOME);},
                            child: Icon(Icons.home_outlined, size: 26, color: Colors.black.withOpacity(0.6)),
                          ),
                          GestureDetector(
                            onTap: (){Get.offAndToNamed(AppRoutes.BOOKFORM);},
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: kDarkColor90,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 30,
                                    color: kDarkColor90.withOpacity(.6),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(Icons.add, size: 30, color: kWhiteColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){Get.toNamed(AppRoutes.DASHBORD);},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon( CupertinoIcons.person, size: 26, color: kOrangeColor.withOpacity(.6)),
                              const Text("Profil",
                                      style: TextStyle(
                                        color: kOrangeColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                      ),
                                    ),
                            ],),
                            
                           
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

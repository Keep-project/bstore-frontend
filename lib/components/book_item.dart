import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookItem extends StatelessWidget {
  final double? width;
  final double? marginRight;
  final dynamic controller;
  final Livre? livre;
  final Function()? onTap;
  const BookItem({
    Key? key,
    this.width,
    this.marginRight,
    this.controller,
    this.livre, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 155,
      margin: EdgeInsets.only(
        right: marginRight ?? kDefaultMargin * 2,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 4),
            blurRadius: 10,
            color: kOrangeColor.withOpacity(0.2),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.DETAILS, arguments: livre!.id );
        },
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.17),
                  image:  DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(livre!.image!)),
                  borderRadius: BorderRadius.circular(15)),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 10),
                Row(children: [
                  Opacity(
                      opacity: 0.6,
                      child: InkWell(
                        onTap: () { onTap!();},
                        child: Icon(livre!.likes! > 0 ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                            color: kOrangeColor, size: 30),
                      )),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "${livre!.likes}",
                    style: const TextStyle(
                      color: kDarkColor86,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
                const SizedBox(width: 20),
                Row(children: [
                 const Opacity(
                      opacity: 0.6,
                      child: Icon(CupertinoIcons.chat_bubble_2_fill,
                          color: kDarkColor86, size: 30)),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "${livre!.nbcommentaires}",
                    style: const TextStyle(
                      color: kDarkColor86,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

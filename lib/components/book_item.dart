import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      margin: const EdgeInsets.only(right: kDefaultMargin * 2, bottom: 10,),
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
        onTap: (){Get.toNamed(AppRoutes.DETAILS);},
        child: Column(
          children: [
            Container(
              height: 208,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/femme-de-pouvoir.jpg")),
                  borderRadius: BorderRadius.circular(15)),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 10),
                Row(children: const [
                  Opacity(
                      opacity: 0.6,
                      child: Icon(CupertinoIcons.heart,
                          color: kOrangeColor, size: 30)),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "8",
                    style: TextStyle(
                      color: kDarkColor86,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
                const SizedBox(width: 20),
                Row(children: const [
                  Opacity(
                      opacity: 0.6,
                      child: Icon(CupertinoIcons.chat_bubble_2_fill,
                          color: kDarkColor86, size: 30)),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "8",
                    style: TextStyle(
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

import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PopularBookItem extends StatelessWidget {
  final EdgeInsets? margin;
  const PopularBookItem({
    Key? key, this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 5,
              vertical: 2),
          margin: margin?? const EdgeInsets.only(
              left: kDefaultMargin * 2, right: kDefaultMargin * 2, bottom: kDefaultMargin*1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kWhiteColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 5,
                color:
                    kOrangeColor.withOpacity(0.059),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.DETAILS);
            },
            child: Row(
              children: [
                Container(
                  height: 180,
                  width: 120,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(8),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/images/jeune-afrique.jpg"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(children: [
                    const Spacer(),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text:
                              "Femme noir femme de pouvoir\n",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w600,
                            color: kDarkColor86,
                          ),
                        ),
                        TextSpan(
                          text: "Jacque Vergès",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w600,
                            color: kDarkColor86
                                .withOpacity(.5),
                          ),
                        ),
                      ]),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Expanded(
                          child: CustomIconData(
                              iconData: CupertinoIcons
                                  .book_fill, value: "150", size: 26),
                        ),
                        Expanded(
                          child: CustomIconData(
                              iconData: CupertinoIcons
                                  .heart_fill, value: "70", size: 26, color: kOrangeColor.withOpacity(.8)),
                        ),
                        const Expanded(
                          child: CustomIconData(
                              iconData: CupertinoIcons
                                  .chat_bubble_2_fill, value: "150", size: 26),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                              margin: const EdgeInsets.only(right: 8),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.12),
                                // color: kOrangeColor39.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text("Roman",
                                  style: TextStyle(
                                    // color: kOrangeColor,
                                    color: Colors.green.withOpacity(.8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                              margin: const EdgeInsets.only(right: 8),
                              height: 30,
                              decoration: BoxDecoration(
                                color: kOrangeColor39.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text("Roman",
                                  style: TextStyle(
                                    color: kOrangeColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                              margin: const EdgeInsets.only(right: 8),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.12),
                                // color: kOrangeColor39.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text("Roman",
                                  style: TextStyle(
                                    // color: kOrangeColor,
                                    color: Colors.green.withOpacity(.8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ]),
                ),
                const SizedBox(
                  width: 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -1,
          right: kDefaultMargin*2.5,
          child:Icon(CupertinoIcons.bookmark, size: 22, color: kDarkColor86.withOpacity(.5) ),)
      ],
    );
  }
}




class CustomIconData extends StatelessWidget {
  final String? value;
  final IconData? iconData;
  final double? size;
  final Color? color;
  final Function()? onPressed;
  const CustomIconData({
    Key? key,
    this.value,
    this.iconData, this.size,
    this.color, this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () { onPressed!();},
          icon: Icon(iconData!, size: size!, color: color ?? kDarkColor86.withOpacity(0.6)),
        ),
        Text(value!, style: TextStyle(color:  kDarkColor86.withOpacity(0.7), fontSize: 16)),
      ],
    );
  }
}
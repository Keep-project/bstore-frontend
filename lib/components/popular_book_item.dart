import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PopularBookItem extends StatelessWidget {
  final EdgeInsets? margin;
  final Livre livre;
  final Function()? onTap;
  const PopularBookItem({
    Key? key,
    this.margin,
    required this.livre, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 5, vertical: 2),
          margin: margin ??
              const EdgeInsets.only(
                  left: kDefaultMargin * 2,
                  right: kDefaultMargin * 2,
                  bottom: kDefaultMargin * 1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kWhiteColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 5,
                color: kOrangeColor.withOpacity(0.059),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.DETAILS, arguments: livre.id!);
            },
            child: Row(
              children: [
                Container(
                  height: 180,
                  width: 120,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(livre.image!),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${livre.titre!.toString().capitalizeFirst}\n",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkColor86,
                                  ),
                                ),
                                Text(
                                  "${livre.auteur!.toString().capitalizeFirst}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkColor86.withOpacity(.5),
                                  ),
                                ),
                              ]),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomIconData(
                                onTap: () {},
                                  iconData: CupertinoIcons.book_fill,
                                  value: "${livre.nbpages!}",
                                  size: 20),
                            ),
                            Expanded(
                              child: CustomIconData(
                                onTap: ()async{ await onTap!();},
                                  iconData: CupertinoIcons.heart_fill,
                                  value: "${livre.likes!}",
                                  size: 20,
                                  color: kOrangeColor.withOpacity(.8)),
                            ),
                            Expanded(
                              child: CustomIconData(
                                onTap: (){},
                                  iconData: CupertinoIcons.chat_bubble_2_fill,
                                  value: "${livre.nbcommentaires!}",
                                  size: 20),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            margin: const EdgeInsets.only(right: 8),
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.green.withOpacity(0.12),
                              color: kOrangeColor39.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                livre.categorie!,
                                style: const TextStyle(
                                  color: kOrangeColor,
                                  // color: Colors.green.withOpacity(.8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
          right: kDefaultMargin * 2.5,
          child: Icon(CupertinoIcons.bookmark,
              size: 22, color: kDarkColor86.withOpacity(.5)),
        )
      ],
    );
  }
}

class CustomIconData extends StatelessWidget {
  final String? value;
  final IconData? iconData;
  final double? size;
  final Color? color;
  final Function()? onTap;
  const CustomIconData({
    Key? key,
    this.value,
    this.iconData,
    this.size,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () async {
            await onTap!();
          },
          child: Icon(iconData!,
              size: size!, color: color ?? kDarkColor86.withOpacity(0.6)),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(value!,
            style:
                TextStyle(color: kDarkColor86.withOpacity(0.7), fontSize: 16)),
      ],
    );
  }
}

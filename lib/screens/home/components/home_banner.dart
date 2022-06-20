import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBannerHeight,
      width: Get.width,
      decoration: const BoxDecoration(
        color: kDarkColor86,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100)
        ),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              const Spacer(),
              Container(
                height: kBannerHeight,
                width: Get.width * 0.5,
                decoration: const BoxDecoration(
                  image:  DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/reading-glasses-pana.png")
                  ),
                )
              ),
            ],
            
          ),
          Positioned(
            top: 40,
            left: 50, 
              child: RichText(
                text: TextSpan(
                  children: [
                  TextSpan(
                    text: "La lecture épanouit l'Homme,\nles discussions l'enrichissent.",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kWhiteColor,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                ],
                )
              )
            ),
            Positioned(
              bottom: 8,
              left: 80, 
              child: RichText(
                text: TextSpan(
                  children: [
                  TextSpan(
                    text: "Bienvenu sur BStore ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kOrangeColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                ],
                )
              )
            ),
        ],
      )
    );
  }
}
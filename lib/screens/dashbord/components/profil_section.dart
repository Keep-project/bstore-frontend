
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/dashbord/components/build_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 

class ProfilSection extends StatelessWidget {
  final dynamic controller;
  const ProfilSection({
    Key? key, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BuildAppBar(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              controller.user.avatar == null ?  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: kWhiteColor,
                      ),
                    ),
                    child: const Center(
                        child: Icon(CupertinoIcons.person_fill,
                            color: kWhiteColor, size: 36))) :

                GestureDetector(
                  onTap: (){
                    controller.chooseImage();
                  },
                  child: Stack(
                    children: [
                      Container(
                          height: 75,
                          width: 75,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: kWhiteColor,
                            ),
                          ),
                          child: Image.network(controller.user.avatar!.toString(), fit: BoxFit.fill),
                          ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child:  Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.edit, size: 20, color: kDarkColor90),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Text(controller.user.username.toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(controller.user.email.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

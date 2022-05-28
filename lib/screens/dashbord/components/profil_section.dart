
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/dashbord/components/build_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 

class ProfilSection extends StatelessWidget {
  const ProfilSection({
    Key? key,
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
                Container(
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
                            color: kWhiteColor, size: 36))),
                const SizedBox(height: kDefaultPadding / 2),
                const Text(
                  "john Doe",
                  style: TextStyle(
                    fontSize: 18,
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "johndoe@gmail.com",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.withOpacity(.5),
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

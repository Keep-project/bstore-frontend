
import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/search_bar.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/home/components/home_banner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            
            children:  <Widget>[
              const HomeBanner(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  <Widget>[
                    const SizedBox(height: 30),
                    const SearchBar(),
                    const SizedBox(height: 20),
                    const HeadTitle(title: "Explorer par thèmes"),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          CategoryItem(title: "Histoire"),
                          CategoryItem(title: "Geographie"),
                          CategoryItem(title: "Philosophie"),
                          CategoryItem(title: "Romans"),
                          CategoryItem(title: "Politique"),
                          CategoryItem(title: "Economie"),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ],
          )
        )

      )
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String? title;
  const CategoryItem({
    Key? key, required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: kDefaultPadding - 4, bottom: kDefaultPadding),
      decoration:  BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 10),
            blurRadius: 20,
            color: kOrangeColor.withOpacity(0.09),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*1.5, vertical: 8),
        child: Text(title!, 
          style: const TextStyle(
            color: kOrangeColor,
            // fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      )
    );
  }
}






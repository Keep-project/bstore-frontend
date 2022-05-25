
// ignore_for_file: avoid_print

import 'package:bstore/components/head_title.dart';
import 'package:bstore/components/search_bar.dart';
import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/home/components/category_item.dart';
import 'package:bstore/screens/home/components/home_banner.dart';
import 'package:flutter/cupertino.dart';
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
                        children: const <Widget>[
                          CategoryItem(title: "Histoire"),
                          CategoryItem(title: "Geographie"),
                          CategoryItem(title: "Philosophie"),
                          CategoryItem(title: "Romans"),
                          CategoryItem(title: "Politique"),
                          CategoryItem(title: "Economie"),
                        ],
                      ),
                    ),
                     const SizedBox(height: 12),
                    Row(
                      children: [
                        const HeadTitle(title: "Livres récents",),
                        const Spacer(),
                        InkWell(
                          onTap: (){print("Voir plus");},
                            child: const Opacity(
                              opacity: 0.5,
                              child:  Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                child: Text("Voir plus", 
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kDarkColor86,
                                  )
                                ),
                              ),
                            )
                          ),
                      ]
                     ),
                     const SizedBox(height: 10),
                     SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Row(
                         children: const <Widget> [
                           BookItem(),
                           BookItem(),
                           BookItem(),
                           BookItem(),
                           BookItem(),
                           BookItem(),
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

class BookItem extends StatelessWidget {
  const BookItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      margin: const EdgeInsets.only(right: kDefaultMargin *2),
      child: Column(
        children: [
          Container(
            height: 208,
            width: double.maxFinite,
            decoration: BoxDecoration(
              boxShadow: [
                 BoxShadow(
                   offset: const Offset(0, 8),
                   blurRadius: 8,
                   color: kDarkColor86.withOpacity(0.2),
                 )
               ],
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/femme-de-pouvoir.jpg")
              ),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Row(
                 children: const [
                   Opacity(
                     opacity: 0.6,
                     child: Icon(CupertinoIcons.heart, color: kOrangeColor, size: 30)),
                   SizedBox(width: 3,),
                   Text("8",
                     style: TextStyle(
                       color: kDarkColor86,
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                     ),
                 ),
                ]
              ),
              const SizedBox(width: 20),
              Row(
                 children: const [
                   Opacity(
                     opacity: 0.6,
                     child: Icon(CupertinoIcons.chat_bubble_2_fill, color: kDarkColor86, size: 30)),
                   SizedBox(width: 3,),
                   Text("8",
                     style: TextStyle(
                       color: kDarkColor86,
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                     ),
                 ),
               ]
             ),
            ],
          ),
          
        ],
      ),
    );
  }
}




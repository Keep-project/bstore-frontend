
import 'package:bstore/core/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(CupertinoIcons.arrow_left),
          title: const Text("BookStore")
        ),
        body:  SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: <Widget>[
                ...List.generate(200, 
                  (index) => Text("Je suis à l'accueil $index")
                )
                
              ],
            ),
          ),
        ),
      )
    );
  }
}
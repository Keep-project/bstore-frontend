import 'package:bstore/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: kGreyColor85,
         boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 30,
            color: Colors.white.withOpacity(0.1),
          )
        ],
        borderRadius: BorderRadius.circular(25)
      ),
      child: TextField(
        style: TextStyle(
          fontSize: 16,
          color: kOrangeColor.withOpacity(0.8),
        ),
        decoration: InputDecoration(
          suffixIcon: const Icon(CupertinoIcons.search, size: 36, color: kOrangeColor),
          hintText: "Rechercher un livre ...",
          contentPadding: const EdgeInsets.all(16),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: TextStyle(
          color: kOrangeColor.withOpacity(0.5),
          fontSize: 16,
        ),
        ),
      ),
    );
  }
}
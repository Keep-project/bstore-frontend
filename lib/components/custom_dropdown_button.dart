import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_size.dart';
import 'package:bstore/screens/book_form/book_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final BookFormScreenController controller;
  final List liste;
  final String selectedItem;
  final Function(dynamic data) onChanged;
  final String helpText;
  const CustomDropDown({
    Key? key,
    required this.controller,
    required this.liste,
    required this.selectedItem,
    required this.onChanged,
    required this.helpText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.6,
          child: Text(
            helpText,
            style: const TextStyle(
              fontSize: 16,
              color: kDarkColor90,
            ),
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1.2,
                color: kOrangeColor39.withOpacity(0.42),
              ),
              borderRadius: BorderRadius.circular(8)),
          child: DropdownButton<dynamic>(
            value: selectedItem,
            icon: const Icon(CupertinoIcons.chevron_down, size: 20),
            elevation: 16,
            isExpanded: true,
            style:
                TextStyle(color: kDarkColor86.withOpacity(0.7), fontSize: 16),
            underline: Container(
              height: 0,
              width: 0,
              color: kDarkColor86,
            ),
            onChanged: (dynamic newValue) {
              onChanged(newValue);
            },
            items: liste.map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value['libelle'],
                child: Text(value['libelle']),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

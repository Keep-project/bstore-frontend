
import 'package:bstore/core/app_colors.dart';
import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  final String? title;
  const HeadTitle({
    Key? key, required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: Theme.of(context).textTheme.bodyLarge!
      .copyWith(
        color: kDarkColor90.withOpacity(0.8),
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }
}
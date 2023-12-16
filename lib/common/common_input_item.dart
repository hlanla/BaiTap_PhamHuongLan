import 'package:flutter/material.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';

class CommonInputItem extends StatelessWidget {
  final String title;
  final Widget inputWidget;
  final Widget? suffixIcon;

  const CommonInputItem({
    Key? key,
    required this.title,
    required this.inputWidget,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.commonTextStyle,
          textAlign: TextAlign.left,
        ),
        kVerticalSpace4,
        inputWidget,
      ],
    );
  }
}

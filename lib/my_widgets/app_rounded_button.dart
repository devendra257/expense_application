// ignore_for_file: must_be_immutable

import 'package:expense_application/constants/app_color.dart';
import 'package:expense_application/constants/my_style.dart';
import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {
  String title;
  Color textColor, bgColor;
  VoidCallback? onTap;
  double elevatedBorderRadius;
  Widget? mWidget;

  AppRoundedButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.textColor = Colors.white,
      this.bgColor = AppColor.blackColor,
      this.elevatedBorderRadius = 11.0,
      this.mWidget});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(elevatedBorderRadius),
        ),
      ),
      child: mWidget == null
          ? Text(
              title,
              style: textStyle16(
                mColor: textColor,
                mFontweight: FontWeight.bold,
              ),
            )
          : mWidget,
    );
  }
}

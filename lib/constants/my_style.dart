import 'package:expense_application/constants/app_color.dart';

import 'package:flutter/material.dart';

// //* Logo Design

// Widget mLogo({required double mWidth}) {
//   return CircleAvatar(
//     radius: mWidth * 0.09,
//     backgroundColor: Colors.grey,
//     child: Image.asset(
//       ImageConstants.appLogo,
//       width: mWidth * 0.1,
//       height: mWidth * 0.1,
//     ),
//   );
// }

//* Spacer Height..

Widget hSpacer({double mHeight = 11}) {
  return SizedBox(height: mHeight);
}

//* Spacer Width..
Widget hWidth({double mWidth = 11}) {
  return SizedBox(
    width: mWidth,
  );
}

//* My Decoration

InputDecoration myDecoration({
  IconData? mPrefixIcon,
  IconData? mSuffixIcon,
  required String mLabel,
  required String mHint,
  VoidCallback? onSuffixIconTap,
}) {
  return InputDecoration(
      label: Text(mLabel),
      hintText: mHint,
      prefixIcon: mPrefixIcon != null ? Icon(mPrefixIcon) : null,
      suffixIcon: mSuffixIcon != null
          ? InkWell(onTap: onSuffixIconTap, child: Icon(mSuffixIcon))
          : null,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColor.blackColor, width: 1)));
}

//* Font Style 14
TextStyle textStyle14({
  Color mColor = Colors.black,
  FontWeight mFontweight = FontWeight.normal,
}) {
  return TextStyle(
    fontSize: 14,
    fontFamily: 'Mulish',
    color: mColor,
    fontWeight: mFontweight,
  );
}

//* Font Style 16
TextStyle textStyle16(
    {Color mColor = Colors.black, FontWeight mFontweight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 16,
    fontFamily: 'Mulish',
    color: mColor,
    fontWeight: mFontweight,
  );
}

//* Font Style 25
TextStyle textStyle25({
  Color mColor = Colors.black,
  FontWeight mFontweight = FontWeight.normal,
}) {
  return TextStyle(
    fontSize: 25,
    fontFamily: 'Mulish',
    color: mColor,
    fontWeight: mFontweight,
  );
}

//* Font Style 34
TextStyle textStyle34({
  Color mColor = Colors.black,
  FontWeight mFontweight = FontWeight.normal,
}) {
  return TextStyle(
    fontSize: 34,
    fontFamily: 'Mulish',
    color: mColor,
    fontWeight: mFontweight,
  );
}

//* Font Style 43
TextStyle textStyle43({
  Color mColor = Colors.black,
  FontWeight mFontweight = FontWeight.normal,
}) {
  return TextStyle(
    fontSize: 34,
    fontFamily: 'Mulish',
    color: mColor,
    fontWeight: mFontweight,
  );
}

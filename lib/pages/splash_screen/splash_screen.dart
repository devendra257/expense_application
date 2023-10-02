import 'dart:async';

import 'package:expense_application/constants/image_constants.dart';
import 'package:expense_application/constants/my_style.dart';
import 'package:expense_application/pages/home_page/home_page.dart';
import 'package:expense_application/pages/user_onboarding/login_page.dart';
import 'package:expense_application/user_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 4),
      () async {
        int uid = await UserPreferences().getUID();
        Widget nextPage;
        if (uid > 0) {
          nextPage = HomePage();
        } else {
          nextPage = LoginPage();
        }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context).size;
    var mWidth = mediaQueryData.width;
    var mHeight = mediaQueryData.height;

    print("mWidth = $mWidth mHeight = $mHeight");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Logo
            CircleAvatar(
              radius: mWidth * 0.055,
              backgroundColor: Colors.grey,
              child: Image.asset(
                ImageConstants.appLogo,
                width: mWidth * 0.06,
                height: mWidth * 0.06,
              ),
            ),

            //* Expense
            Text(
              'Expense',
              style: mWidth > 1000
                  ? textStyle34(mFontweight: FontWeight.bold)
                  : textStyle25(mFontweight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

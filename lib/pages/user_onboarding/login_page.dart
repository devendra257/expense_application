import 'package:expense_application/bloc/user_bloc/user_bloc.dart';
import 'package:expense_application/bloc/user_bloc/user_event.dart';
import 'package:expense_application/bloc/user_bloc/user_state.dart';
import 'package:expense_application/constants/app_color.dart';
import 'package:expense_application/constants/image_constants.dart';
import 'package:expense_application/constants/my_style.dart';
import 'package:expense_application/my_widgets/app_rounded_button.dart';
import 'package:expense_application/pages/home_page/home_page.dart';
import 'package:expense_application/pages/user_onboarding/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPassword = false;
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var mWidth = mediaQueryData.size.width;
    var mHeight = mediaQueryData.size.height;
    var mOrientation = mediaQueryData.orientation;
    print('Media Query Width: $mWidth Media Query Height: $mHeight ');
    return Scaffold(
      //* Orientation Handle
      body: Padding(
        padding: const EdgeInsets.all(21.0),
        child: mOrientation == Orientation.portrait
            ? portraitUI(mWidth, mHeight)
            : landScapeUI(mWidth, mHeight),
      ),
    );
  }

//* Main UI

  Widget mainUI(double mWidth, double mHeight) {
    return mHeight > 400

        //* Above Height 350
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: mWidth * 0.08,
                backgroundColor: AppColor.greyDarkColor,
                child: Image.asset(
                  ImageConstants.appLogo,
                  width: mWidth * 0.1,
                  height: mWidth * 0.1,
                ),
              ),
              SizedBox(
                width: mWidth * 0.4,
                child: FittedBox(
                  child: Text(
                    'Welcome to the app',
                    style: textStyle25(
                      mFontweight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              hSpacer(),
              TextField(
                controller: emailController,
                decoration: myDecoration(
                  mLabel: 'Email / Mobile Number',
                  mHint: 'Enter Your Email/ Mobile Number',
                  mPrefixIcon: Icons.email,
                ),
              ),
              hSpacer(),
              TextField(
                controller: passController,
                obscureText: !isPassword,
                obscuringCharacter: '*',
                decoration: myDecoration(
                  mLabel: 'Password',
                  mHint: 'Enter Your Password',
                  mPrefixIcon: Icons.password,
                  mSuffixIcon:
                      isPassword ? Icons.visibility : Icons.visibility_off,
                  onSuffixIconTap: () {
                    isPassword = !isPassword;
                    setState(() {});
                  },
                ),
              ),
              hSpacer(
                mHeight: 30,
              ),
              BlocConsumer<UserBloc, UserState>(
                listener: (_, state) {
                  if (state is UserSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User Logged in')));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  } else if (state is UserFailState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.failMsg)));
                  }
                },
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: AppRoundedButton(
                      title: 'Login',
                      onTap: () {
                        var email = emailController.text.toString();
                        var password = passController.text.toString();
                        var mobno = emailController.text.toString();

                        context.read<UserBloc>().add(
                              LoginUserEvent(
                                email: email,
                                password: password,
                                mobno: mobno,
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: AppRoundedButton(
                    title: "Create Account",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    }),
              )
            ],
          )

        //* Below Height 350
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: mWidth * 0.08,
                  backgroundColor: AppColor.greyDarkColor,
                  child: Image.asset(
                    ImageConstants.appLogo,
                    width: mWidth * 0.1,
                    height: mWidth * 0.1,
                  ),
                ),
                SizedBox(
                  width: mWidth * 0.4,
                  child: FittedBox(
                    child: Text(
                      'Welcome to the app',
                      style: textStyle25(
                        mFontweight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                hSpacer(),
                TextField(
                  decoration: myDecoration(
                    mLabel: 'Email',
                    mHint: 'Enter Your Email',
                    mPrefixIcon: Icons.email,
                  ),
                ),
                hSpacer(),
                TextField(
                  obscureText: !isPassword,
                  obscuringCharacter: '*',
                  decoration: myDecoration(
                    mLabel: 'Password',
                    mHint: 'Enter Your Password',
                    mPrefixIcon: Icons.password,
                    mSuffixIcon:
                        isPassword ? Icons.visibility : Icons.visibility_off,
                    onSuffixIconTap: () {
                      isPassword = !isPassword;
                      setState(() {});
                    },
                  ),
                ),
                hSpacer(
                  mHeight: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppRoundedButton(
                    title: 'Login',
                    onTap: () {},
                  ),
                )
              ],
            ),
          );
  }

  //* Portrait Ui
  Widget portraitUI(double mWidth, double mHeight) {
    return mainUI(mWidth, mHeight);
  }

//* LandScape UI
  Widget landScapeUI(double mWidth, double mHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CircleAvatar(
            radius: mHeight * 0.08,
            backgroundColor: AppColor.greyDarkColor,
            child: Image.asset(
              ImageConstants.appLogo,
              width: mWidth * 0.1,
              height: mHeight * 0.1,
            ),
          ),
        ),
        Expanded(
          //* Layout UI
          child: LayoutBuilder(builder: (context, constraints) {
            var mWidth = constraints.maxWidth;
            var mHeight = constraints.maxHeight;
            print('Layout Width: $mWidth Layout Height: $mHeight ');

            return mainUI(constraints.maxWidth, mHeight);
          }),
        )
      ],
    );
  }
}

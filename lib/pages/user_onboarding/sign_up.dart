import 'package:expense_application/bloc/user_bloc/user_bloc.dart';
import 'package:expense_application/bloc/user_bloc/user_event.dart';
import 'package:expense_application/bloc/user_bloc/user_state.dart';
import 'package:expense_application/constants/my_style.dart';
import 'package:expense_application/model/user_model.dart';
import 'package:expense_application/my_widgets/app_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var mobNoController = TextEditingController();
  var genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(fontSize: 35),
          ),
          hSpacer(),
          TextField(
            controller: emailController,
            decoration:
                myDecoration(mLabel: 'Email', mHint: 'Enter Your Email'),
          ),
          hSpacer(),
          TextField(
            controller: passController,
            decoration:
                myDecoration(mLabel: 'Password', mHint: 'Enter Your Password'),
          ),
          hSpacer(),
          TextField(
            controller: mobNoController,
            decoration: myDecoration(
                mLabel: 'Mobile Number', mHint: 'Enter Your Mobile Number'),
          ),
          hSpacer(),
          TextField(
            controller: genderController,
            decoration:
                myDecoration(mLabel: 'Gender', mHint: 'Enter Your Gender'),
          ),
          hSpacer(mHeight: 21),
          BlocConsumer<UserBloc, UserState>(
            //* Bloc Listener only use for listener to data not rebuild to ui part then return karne ke jarur ni hai....
            listener: (context, state) {
              if (state is UserSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User Account to Created')));
                Navigator.pop(context);
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
              return AppRoundedButton(
                title: 'Create Account',
                onTap: () {
                  var email = emailController.text.toString();
                  var password = passController.text.toString();
                  var mobno = mobNoController.text.toString();
                  var gender = genderController.text.toString();

                  context.read<UserBloc>().add(
                        CreateNewAccountEvent(
                          newUser: UserModel(
                            email: email,
                            password: password,
                            mobno: mobno,
                            gender: gender,
                          ),
                        ),
                      );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

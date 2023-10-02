import 'package:expense_application/Database/appdatabase.dart';
import 'package:expense_application/bloc/expense_bloc.dart';
import 'package:expense_application/bloc/user_bloc/user_bloc.dart';
import 'package:expense_application/pages/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      //* Expense Bloc
      BlocProvider(create: (context) => ExpenseBloc(db: AppDataBase.db)),

      //* User Bloc
      BlocProvider(create: (context) => UserBloc(db: AppDataBase.db))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

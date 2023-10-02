import 'package:expense_application/bloc/expense_bloc.dart';
import 'package:expense_application/bloc/expense_event.dart';
import 'package:expense_application/bloc/expense_state.dart';
import 'package:expense_application/constants/app_data_constants.dart';
import 'package:expense_application/pages/add_transaction/add_transaction.dart';
import 'package:expense_application/pages/user_onboarding/login_page.dart';
import 'package:expense_application/user_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Add App Bar
      appBar: AppBar(
        title: const Text('All Expenses'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTransactionPage(),
                  ));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpenseErrorState) {
            return Center(
              child: Text(state.errorMsg),
            );
          } else if (state is ExpenseLoadedState) {
            return ListView.builder(
              itemCount: state.listExpenses.length,
              itemBuilder: (context, index) {
                var imagePath = "";

                imagePath = AppDataConstants.categories.firstWhere((element) =>
                    element['id'] == state.listExpenses[index].expCatId)['img'];

                // //? Using For loop

                // for (int i = 0; i < AppDataConstants.categories.length; i++) {
                //   if (AppDataConstants.categories[i][index] ==
                //       state.listExpenses[index].expCatId) {
                //     imagePath = AppDataConstants.categories[i]['img'];
                //   }
                // }

                //? Using For each loop
                // for (Map<String, dynamic> eachImage
                //     in AppDataConstants.categories) {
                //   if (eachImage['id'] == state.listExpenses[index].expCatId) {
                //     imagePath = eachImage['img'];
                //     break;
                //   }
                // }

                return ListTile(
                  leading: Image.asset(imagePath),
                  title: Text(state.listExpenses[index].expTitle),
                  subtitle: Text(state.listExpenses[index].expDesc),
                  trailing: Text(
                    ('\$ ${state.listExpenses[index].expAmt}'),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text(
              'No Any Expense Here ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserPreferences().setUID(0);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        },
        child: const Icon(
          Icons.logout,
          size: 35,
        ),
      ),
    );
  }
}

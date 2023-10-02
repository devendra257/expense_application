import 'package:expense_application/bloc/expense_bloc.dart';
import 'package:expense_application/bloc/expense_event.dart';
import 'package:expense_application/constants/app_data_constants.dart';
import 'package:expense_application/constants/my_style.dart';
import 'package:expense_application/model/expense_model.dart';
import 'package:expense_application/my_widgets/app_rounded_button.dart';
import 'package:expense_application/user_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  //* Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amtController = TextEditingController();

  int selectedIndex = -1;
  var selectedType = ['Debit', 'Credit'];
  var firstItemDropDown = 'Debit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: myDecoration(
                mLabel: 'Title',
                mHint: 'Enter Your Title',
              ),
            ),
            hSpacer(),
            TextField(
              controller: descController,
              decoration: myDecoration(
                  mLabel: 'Description', mHint: 'Enter Your Description'),
            ),
            hSpacer(),
            TextField(
              keyboardType: TextInputType.number,
              controller: amtController,
              decoration:
                  myDecoration(mLabel: 'Amount', mHint: 'Enter Your Amount'),
            ),
            hSpacer(mHeight: 21),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppRoundedButton(
                  title: 'Choose Category',
                  mWidget: selectedIndex >= 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              '${AppDataConstants.categories[selectedIndex]['img']}',
                              width: 30,
                            ),
                            Text(
                              '  ${AppDataConstants.categories[selectedIndex]['name']}',
                              style: textStyle16(
                                mColor: Colors.white,
                                mFontweight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      : null,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: GridView.builder(
                              itemCount: AppDataConstants.categories.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    selectedIndex = index;
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        '${AppDataConstants.categories[index]['img']}',
                                        width: 50,
                                      ),
                                      Text(
                                        '${AppDataConstants.categories[index]['name']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(height: 1.3),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            hSpacer(mHeight: 21),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: DropdownButton(
                dropdownColor: Colors.amber,
                borderRadius: BorderRadius.circular(21),
                isExpanded: true,
                value: firstItemDropDown,
                items: selectedType
                    .map((element) => DropdownMenuItem(
                          value: element,
                          child: Text(element),
                        ))
                    .toList(),
                onChanged: (value) {
                  // todo: Debit and Credit value ko change karne ke liye onChanged to Call Karke setstate kiya..
                  firstItemDropDown = value!;
                  setState(() {});
                },
              ),
            ),
            AppRoundedButton(
              title: "Add Expense",
              onTap: () async {
                context.read<ExpenseBloc>().add(
                      AddExpenseEvent(
                        newExpense: ExpenseModel(
                          userId: await UserPreferences().getUID(),
                          expTitle: titleController.text.toString(),
                          expDesc: descController.text.toString(),
                          expAmt: double.parse(amtController.text.toString()),
                          expBal: 0,
                          //! It is important
                          expType: firstItemDropDown == 'Debit' ? 0 : 1,
                          //! It is important
                          expCatId: AppDataConstants.categories[selectedIndex]
                              ['id'],
                          //! It is important
                          expTime: DateTime.now().toString(),
                        ),
                      ),
                    );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

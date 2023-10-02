import 'package:expense_application/model/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  ExpenseModel newExpense;

  AddExpenseEvent({required this.newExpense});
}

class FetchAllExpense extends ExpenseEvent {
  //* agar data se ap id ke though me ap data ko fetch karna to apko id pass karna hoga like

  // int id;

  // FetchAllExpense({required this.id});

  //* But hum shared preferense se id kar ko storage kara denge to id ki jarurt ni hoga..
}

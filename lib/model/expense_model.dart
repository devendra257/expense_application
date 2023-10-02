import 'package:expense_application/Database/appdatabase.dart';

class ExpenseModel {
  int? expId;
  int userId;
  String expTitle;
  String expDesc;
  num expAmt;
  num expBal;
  int expType;
  int expCatId;
  String expTime;

  ExpenseModel({
    this.expId,
    required this.userId,
    required this.expTitle,
    required this.expDesc,
    required this.expAmt,
    required this.expBal,
    required this.expType,
    required this.expCatId,
    required this.expTime,
  });

  factory ExpenseModel.formMap(Map<String, dynamic> map) {
    return ExpenseModel(
        expId: map[AppDataBase.EXPENSE_ID],
        userId: map[AppDataBase.USER_COLUMN_ID],
        expTitle: map[AppDataBase.EXPENSE_TITLE],
        expDesc: map[AppDataBase.EXPENSE_DESC],
        expAmt: map[AppDataBase.EXPENSE_AMT],
        expBal: map[AppDataBase.EXPENSE_BAL],
        expType: map[AppDataBase.EXPENSE_TYPE],
        expCatId: map[AppDataBase.EXPENSE_CAT_ID],
        expTime: map[AppDataBase.EXPENSE_TIME]);
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.EXPENSE_ID: expId,
      AppDataBase.USER_COLUMN_ID: userId,
      AppDataBase.EXPENSE_TITLE: expTitle,
      AppDataBase.EXPENSE_DESC: expDesc,
      AppDataBase.EXPENSE_AMT: expAmt,
      AppDataBase.EXPENSE_BAL: expBal,
      AppDataBase.EXPENSE_TYPE: expType,
      AppDataBase.EXPENSE_CAT_ID: expCatId,
      AppDataBase.EXPENSE_TIME: expTime,
    };
  }
}

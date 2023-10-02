import 'dart:io';

import 'package:expense_application/model/expense_model.dart';
import 'package:expense_application/model/user_model.dart';
import 'package:expense_application/user_prefs/user_preferences.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  AppDataBase._();

  static final AppDataBase db = AppDataBase._();

  Database? _database;

  static const EXPENSE_TABLE = 'exp_table';

  static const EXPENSE_ID = 'exp_id';
  static const EXPENSE_TITLE = 'exp_title';
  static const EXPENSE_DESC = 'exp_desc';
  static const EXPENSE_AMT = 'exp_amt';
  static const EXPENSE_BAL = 'exp_bal';
  static const EXPENSE_TYPE = 'exp_type'; // todo: 0-> debit 1-> Credit
  static const EXPENSE_CAT_ID = 'exp_cat_id';
  static const EXPENSE_TIME = 'exp_time';

  static const USER_TABLE = 'user_table';
  static const USER_COLUMN_ID = 'ur_id';
  static const USER_COLUMN_EMAIl = 'ur_email';
  static const USER_COLUMN_PASS = 'ur_pass';
  static const USER_COLUMN_MOB_NO = 'ur_mob_no';
  static const USER_COLUMN_GENDER = 'ur_gender';

  Future<Database> getDB() async {
    if (_database != null) {
      return _database!;
    } else {
      return _database = await initDB();
    }
  }

//* Create Database
  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(documentDirectory.path, 'expenseDB.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "Create table $EXPENSE_TABLE ( $EXPENSE_ID integer primary key autoincrement, $USER_COLUMN_ID integer, $EXPENSE_TITLE text, $EXPENSE_DESC text, $EXPENSE_AMT real, $EXPENSE_BAL real, $EXPENSE_TYPE interge, $EXPENSE_CAT_ID integer, $EXPENSE_TIME text )");

        db.execute(
            "Create table $USER_TABLE ( $USER_COLUMN_ID integer primary key autoincrement, $USER_COLUMN_EMAIl text unique, $USER_COLUMN_PASS text, $USER_COLUMN_MOB_NO text, $USER_COLUMN_GENDER text )");
      },
    );
  }

  //* Create New User Account

  Future<bool> createAccountByUser(UserModel newModel) async {
    var check = await userAlreadyExist(newModel.email, newModel.mobno);
    var db = await getDB();

    if (!check) {
      var inserted = await db.insert(USER_TABLE, newModel.toMap());
      return inserted > 0;
    } else {
      return false;
    }
  }

  //* How to Check Already Exist User Account

  Future<bool> userAlreadyExist(String email, String mobno) async {
    var db = await getDB();

    var userExist = await db.query(USER_TABLE,
        where: "$USER_COLUMN_EMAIl = ? or $USER_COLUMN_MOB_NO = ?",
        whereArgs: [email, mobno]);

    return userExist.isNotEmpty;
  }

  //* User login / Authorization

  Future<bool> authorizeUser(
      String mobno, String email, String password) async {
    var db = await getDB();

    List<Map<String, dynamic>> userLogin = await db.query(USER_TABLE,
        where:
            "($USER_COLUMN_EMAIl = ? or $USER_COLUMN_MOB_NO = ?) and $USER_COLUMN_PASS = ?",
        whereArgs: [mobno, email, password]);

    if (userLogin.isNotEmpty) {
      //! it is very important line because of user id data set for always login to app..
      UserPreferences().setUID(userLogin[0][USER_COLUMN_ID]);
    }

    return userLogin.isNotEmpty;
  }

  //* Add New Expense

  Future<bool> addExpense(ExpenseModel newExpense) async {
    var db = await getDB();

    var check = await db.insert(EXPENSE_TABLE, newExpense.toMap());

    return check > 0;
  }

//* Fetch Expense Data

//! it is very important line to fetch of all data..
  Future<List<ExpenseModel>> fetchExpensesofUser() async {
    var db = await getDB();

    //? it is used for get the user id
    int id = await UserPreferences().getUID();

    //* All data nahi chahiye isliye  isliye user id se get karna h
    List<Map<String, dynamic>> expenseData = await db
        .query(EXPENSE_TABLE, where: "$USER_COLUMN_ID = ?", whereArgs: ["$id"]);

    List<ExpenseModel> arryExpense = [];

    for (Map<String, dynamic> eachExpenseData in expenseData) {
      //* Add me hum expense model chahiye or to data map ke form me aa rha h to use hum model me convert karne list ko provide kar denge..

      arryExpense.add(ExpenseModel.formMap(eachExpenseData));
    }

    return arryExpense;
  }
}

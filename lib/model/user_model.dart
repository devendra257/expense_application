import 'package:expense_application/Database/appdatabase.dart';

class UserModel {
  int? uid;
  String email;
  String password;
  String mobno;
  String gender;

  UserModel({
    this.uid,
    required this.email,
    required this.password,
    required this.mobno,
    required this.gender,
  });

  factory UserModel.formMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map[AppDataBase.USER_COLUMN_ID],
      email: map[AppDataBase.USER_COLUMN_EMAIl],
      password: map[AppDataBase.USER_COLUMN_PASS],
      mobno: map[AppDataBase.USER_COLUMN_MOB_NO],
      gender: map[AppDataBase.USER_COLUMN_GENDER],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.USER_COLUMN_ID: uid,
      AppDataBase.USER_COLUMN_EMAIl: email,
      AppDataBase.USER_COLUMN_PASS: password,
      AppDataBase.USER_COLUMN_MOB_NO: mobno,
      AppDataBase.USER_COLUMN_GENDER: gender,
    };
  }
}

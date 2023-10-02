import 'package:expense_application/model/user_model.dart';

abstract class UserEvent {}

class CreateNewAccountEvent extends UserEvent {
  UserModel newUser;

  CreateNewAccountEvent({required this.newUser});
}

class LoginUserEvent extends UserEvent {
  String email;
  String password;
  String mobno;

  LoginUserEvent(
      {required this.email, required this.password, required this.mobno});
}

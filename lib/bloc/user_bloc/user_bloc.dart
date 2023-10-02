import 'package:expense_application/Database/appdatabase.dart';
import 'package:expense_application/bloc/user_bloc/user_event.dart';
import 'package:expense_application/bloc/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  AppDataBase db;

  UserBloc({required this.db}) : super(UserInitialState()) {
    on<CreateNewAccountEvent>(
      (event, emit) async {
        emit(UserLoadingState());

        bool check = await db.createAccountByUser(event.newUser);

        if (check) {
          emit(UserSuccessState());
        } else {
          emit(UserFailState(failMsg: "Email/Mobile Number is already exist"));
        }
      },
    );

    on<LoginUserEvent>((event, emit) async {
      emit(UserLoadingState());

      bool check =
          await db.authorizeUser(event.mobno, event.email, event.password);

      if (check) {
        emit(UserSuccessState());
      } else {
        emit(UserFailState(failMsg: "Invalid User id and Password"));
      }
    });
  }
}

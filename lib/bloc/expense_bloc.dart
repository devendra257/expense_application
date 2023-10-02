import 'package:expense_application/Database/appdatabase.dart';
import 'package:expense_application/bloc/expense_event.dart';
import 'package:expense_application/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  AppDataBase db;

  ExpenseBloc({required this.db}) : super(ExpenseInitialState()) {
    //* Add Expense Method
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      var check = await db.addExpense(event.newExpense);

      if (check) {
        var data = await db.fetchExpensesofUser();
        emit(ExpenseLoadedState(listExpenses: data));
      } else {
        emit(ExpenseErrorState(errorMsg: 'Something when wrong'));
      }
    });

    //* Fetch All Data Method

    on<FetchAllExpense>((event, emit) async {
      emit(ExpenseLoadingState());
      var data = await db.fetchExpensesofUser();
      emit(ExpenseLoadedState(listExpenses: data));
    });
  }
}

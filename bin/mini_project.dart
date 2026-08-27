import 'package:mini_project/mini_project.dart' as mini_project;
import 'dart:io';
import 'package:mini_project/logic_Search.dart' as logic_Search;
import 'package:mini_project/logic_ADE.dart' as logic_ADE;
import 'package:mini_project/logic_T.dart' as logic_T;

void main(List<String> arguments) {
  print('Hello world: ${mini_project.calculate()}!');
  show();
  print('Choose an option: ');
  String? choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      logic_Search.showexpenses();
      break;
    case '2':
      addExpense();
      break;
    case '3':
      editExpense();
      break;
    case '4':
      deleteExpense();
      break;
    case '5':
      logic_Search.Search();
      break;
    case '6':
      logic_Search.filterByCategory();
      break;
    case '7':
      todayExpenses();
      break;
    case '8':
      totalExpenses();
      break;
    case '9':
      limitExpenses();
      break;
    case '10':
      print('Exiting...');
      exit(0);
    default:
      print('Invalid choice. Please try again.');
  }
}

void show() {
  print('--- Expense Tracker ---');
  print('');
  print('--- Main Menu ---   ');
  print('1. Show expenses');
  print('2. Add expense');
  print('3. Edit expense');
  print('4. Delete expense');
  print('5. Search expenses');
  print('6. Filter expenses by category');
  print('7. Today expenses');
  print('8. Total expenses');
  print('9. Limit expenses');
  print('10. Exit');
}

showexpenses() {}
addExpense() {}
editExpense() {}
deleteExpense() {}
Search() {}
filterByCategory() {}
todayExpenses() {}
totalExpenses() {}
limitExpenses() {}

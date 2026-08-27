import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mini_project/model.dart';

const String expensesUrl = 'http://localhost:3000/expenses';

const Map<int, String> categoryNames = {
  1: 'Food',
  2: 'Transportation',
  3: 'Shopping',
  4: 'Others',
};

Future<List<Expense>> _fetchExpenses() async {
  final response = await http.get(Uri.parse(expensesUrl));

  if (response.statusCode != 200) {
    throw HttpException(
      'Server returned status ${response.statusCode}',
      uri: Uri.parse(expensesUrl),
    );
  }

  final decoded = jsonDecode(response.body);
  if (decoded is! List) {
    throw const FormatException('Expected an expenses array from the server');
  }

  return decoded
      .map((item) => Expense.formJSON(Map<String, dynamic>.from(item as Map)))
      .toList();
}

void _printExpenses(Iterable<Expense> expenses) {
  final items = expenses.toList();
  if (items.isEmpty) {
    print('No expenses found.');
    return;
  }

  for (var index = 0; index < items.length; index++) {
    final expense = items[index];
    final category = categoryNames[expense.type] ?? 'Unknown';
    print(
      '${index + 1}. ${expense.title} | ${expense.price.toStringAsFixed(2)} | '
      '$category | ${expense.date}',
    );
  }
}

Future<void> showexpenses() async {
  print('--- All Expenses ---');
  try {
    _printExpenses(await _fetchExpenses());
  } catch (error) {
    print('Unable to load expenses: $error');
  }
}

Future<void> Search() async {
  stdout.write('Enter search query: ');
  final query = stdin.readLineSync()?.trim().toLowerCase() ?? '';
  if (query.isEmpty) {
    print('Please enter a search query.');
    return;
  }

  try {
    final expenses = await _fetchExpenses();
    final results = expenses.where((expense) {
      final category = categoryNames[expense.type] ?? 'unknown';
      return expense.title.toLowerCase().contains(query) ||
          expense.date.toLowerCase().contains(query) ||
          category.toLowerCase().contains(query);
    });
    print('--- Search Results ---');
    _printExpenses(results);
  } catch (error) {
    print('Unable to search expenses: $error');
  }
}

Future<void> filterByCategory() async {
  stdout.write(
    'Select Category (1: food, 2: transportation, 3: shopping, 4: others): ',
  );
  final category = int.tryParse(stdin.readLineSync()?.trim() ?? '');
  if (category == null || !categoryNames.containsKey(category)) {
    print('Invalid category. Please choose a number from 1 to 4.');
    return;
  }

  try {
    final expenses = await _fetchExpenses();
    print('--- ${categoryNames[category]} Expenses ---');
    _printExpenses(expenses.where((expense) => expense.type == category));
  } catch (error) {
    print('Unable to filter expenses: $error');
  }
}

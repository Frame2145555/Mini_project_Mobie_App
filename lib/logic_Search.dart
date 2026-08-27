import 'dart:io';

void showexpenses() {
  print('--- All Expenses ---');
  print('1. Dinner | 50.0 | 🍔 | 2026-08-26');
  //add more expenses here
}

void Search() {
  print('Enter search query:');
  String? query = stdin.readLineSync();
  // Add search logic here
}

void filterByCategory() {
  print('Select Category (1:food, 2:transportation, 3:shopping, 4:others):');
  String? category = stdin.readLineSync();
  // Add filter logic here
}

class Expense {
  String id = '';
  String title = '';
  double price = 0;
  int type = 1;
  String date = '';

  //constructor
  Expense({
    required this.id,
    required this.title,
    required this.price,
    required this.type,
    required this.date,
  });

  //convert json to map
  factory Expense.formJSON(Map<String, dynamic> json) {
    return Expense(
      id: json['id'].toString(),
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      type: json['type'] as int,
      date: json['date'] as String,
    );
  }


  //convert model to json
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'type': type,
      'date': date,
    };
  }
}
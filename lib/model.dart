class Expense {
	Expense({
		this.id,
		required this.title,
		required this.price,
		required this.type,
		required this.date,
	});

	factory Expense.fromJson(Map<String, dynamic> json) {
		final rawId = json['id'];

		return Expense(
			id: rawId?.toString(),
			title: _readRequiredString(json, 'title'),
			price: _readPrice(json['price']),
			type: _readType(json['type']),
			date: _readDate(json['date']),
		);
	}

	String? id;
	String title;
	double price;
	int type;
	DateTime date;

	Map<String, dynamic> toJson() {
		return {
			if (id != null) 'id': id,
			'title': title,
			'price': price,
			'type': type,
			'date': _formatDate(date),
		};
	}

	Expense copyWith({
		String? id,
		String? title,
		double? price,
		int? type,
		DateTime? date,
	}) {
		return Expense(
			id: id ?? this.id,
			title: title ?? this.title,
			price: price ?? this.price,
			type: type ?? this.type,
			date: date ?? this.date,
		);
	}

	static String _readRequiredString(Map<String, dynamic> json, String key) {
		final value = json[key];
		if (value is! String || value.trim().isEmpty) {
			throw FormatException('Expense $key must be a non-empty string');
		}
		return value;
	}

	static double _readPrice(dynamic value) {
		if (value is num) return value.toDouble();
		if (value is String) {
			final parsed = double.tryParse(value);
			if (parsed != null) return parsed;
		}
		throw const FormatException('Expense price must be a number');
	}

	static int _readType(dynamic value) {
		if (value is int) return value;
		if (value is num) return value.toInt();
		if (value is String) {
			final parsed = int.tryParse(value);
			if (parsed != null) return parsed;
		}
		throw const FormatException('Expense type must be an integer');
	}

	static DateTime _readDate(dynamic value) {
		if (value is DateTime) return value;
		if (value is String) {
			final parsed = DateTime.tryParse(value);
			if (parsed != null) return parsed;
		}
		throw const FormatException('Expense date must be an ISO date string');
	}

	static String _formatDate(DateTime value) {
		final month = value.month.toString().padLeft(2, '0');
		final day = value.day.toString().padLeft(2, '0');
		return '${value.year}-$month-$day';
	}
}

class TransactionModel {
  final int? id;
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'description': description,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      description: map['description'],
      amount: map['amount'] is int
          ? (map['amount'] as int).toDouble()
          : map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }
}

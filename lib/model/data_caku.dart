class Caku {
  late int? id;
  late int amount;
  late int categoryId;
  late String date;
  late String description;
  late String type;

  Caku(
      {this.id,
      required this.amount,
      required this.categoryId,
      required this.date,
      required this.description,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'date': date,
      'description': description,
      'type': type
    };
  }

  Caku.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    amount = map['amount'];
    categoryId = map['categoryId'];
    date = map['date'];
    description = map['description'];
    type = map['type'];
  }
}

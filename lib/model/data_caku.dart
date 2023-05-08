class Caku {
  late int? id;
  late int amount;
  late int categoryId;
  late String date;
  late String description;
  late String type;
  // late String? masuk;
  // late String? keluar;
  // late String? saldo;

  Caku(
      {this.id,
      required this.amount,
      required this.categoryId,
      required this.date,
      required this.description,
      required this.type
      // this.masuk,s
      // this.keluar,
      // this.saldo
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'date': date,
      'description': description,
      'type': type
      // 'masuk': masuk,
      // 'keluar': keluar,
      // 'saldo': saldo,
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

  // Caku copyWith(int? amount, int? categoryId, String? date, String? description,
  //     String? type) {
  //   return Caku(
  //       amount: amount ?? this.amount,
  //       categoryId: categoryId ?? this.categoryId,
  //       date: date ?? this.date,
  //       description: description ?? this.description,
  //       type: type ?? this.type);
  // }
}

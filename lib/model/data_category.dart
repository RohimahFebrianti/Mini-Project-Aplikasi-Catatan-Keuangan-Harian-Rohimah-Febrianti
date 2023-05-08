class Categoryes {
  late int? id;
  late String name;
  late String type;

  Categoryes({
    this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory Categoryes.fromMap(Map<String, dynamic> map) {
    return Categoryes(
      id: map['id'],
      name: map['name'],
      type: map['type'],
    );
  }
}

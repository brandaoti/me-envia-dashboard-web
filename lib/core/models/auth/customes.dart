typedef CustomersList = List<Customers>;

class Customers {
  final String id;
  final String name;
  final int totalItems;

  const Customers({
    required this.id,
    required this.name,
    required this.totalItems,
  });

  factory Customers.fromJson(Map json) {
    return Customers(
      id: json['id'],
      name: json['name'],
      totalItems: int.tryParse(json['totalItems']) ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customers &&
        other.id == id &&
        other.name == name &&
        other.totalItems == totalItems;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ totalItems.hashCode;

  @override
  String toString() =>
      'Customes(id: $id, name: $name, totalItems: $totalItems)';
}

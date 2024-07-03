class Item {
  final int id;
  final String name;
  final String expirationDate;
  final String authorId;
  final DateTime createdAt;

  Item({
    required this.id,
    required this.name,
    required this.expirationDate,
    required this.authorId,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      expirationDate: json['expiration_date'],
      authorId: json['author_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
class FeedItem {
  final int id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final DateTime createdAt;

  FeedItem({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
  });

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      authorId: json['author_id'],
      authorName: json['author_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
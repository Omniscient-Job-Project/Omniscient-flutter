class Board {
  final int boardId;
  final String title;
  final String content;
  final String category;
  final String createdAt;
  final String? updatedAt;
  final bool status;

  Board({
    required this.boardId,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    this.updatedAt,
    required this.status,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      boardId: json['boardid'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
    );
  }
}

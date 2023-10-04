class ChattingMessage {
  final String updatedAt;
  final String content;
  final int id;
  final String user;
  ChattingMessage({
    required this.updatedAt,
    required this.content,
    required this.id,
    required this.user,
  });

  factory ChattingMessage.fromJson(Map<String, dynamic> json) {
    return ChattingMessage(
      updatedAt: json['updatedAt'] as String,
      content: json['content'] as String,
      id: json['id'] as int,
      user: json['room']['auction']['user']['nickname'] as String,
    );
  }
}

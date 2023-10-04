import 'dart:ffi';

class ResponseChattingMessage {
  final int userId;
  final String content;
  final String createAt;

  ResponseChattingMessage({
    required this.userId,
    required this.createAt,
    required this.content,
  });

  factory ResponseChattingMessage.fromJson(Map<String, dynamic> json) {
    return ResponseChattingMessage(
      createAt: json['createAt'] as String,
      content: json['content'] as String,
      userId: json['user']['id'] as int,
    );
  }
}

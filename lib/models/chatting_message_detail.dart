class ChattingMessageDetail {
  final int userId;
  final String content;
  final String createdAt;

  ChattingMessageDetail({
    required this.userId,
    required this.createdAt,
    required this.content,
  });

  factory ChattingMessageDetail.fromJson(Map<String, dynamic> json) {
    return ChattingMessageDetail(
      createdAt: json['createdAt'] as String,
      content: json['content'] as String,
      userId: json['user']['id'] as int,
    );
  }

  factory ChattingMessageDetail.fromJson2(Map<String, dynamic> json) {
    return ChattingMessageDetail(
      createdAt: json['createdAt'] as String,
      content: json['content'] as String,
      userId: json['userId'] as int,
    );
  }

  factory ChattingMessageDetail.fromJson3(Map<String, dynamic> json) {
    return ChattingMessageDetail(
      createdAt: json['createdAt'] as String,
      content: json['content'] as String,
      userId: json['userId'] as int,
    );
  }
}

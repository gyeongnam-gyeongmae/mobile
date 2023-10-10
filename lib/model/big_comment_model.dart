class BigCommentModel{
  final int id;
  final String content;
  final int userId;
  final String nickName;
  final int likeCount;
  final DateTime createdAt;
  final String imageUrl;

  BigCommentModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.nickName,
    required this.createdAt,
    required this.likeCount,
    required this.imageUrl
  }); 

  factory BigCommentModel.fromJson(Map<String, dynamic> json){
    return BigCommentModel(
      id: json['id'],
      content: json['content'],
      userId: json['userId'],
      nickName: json['nickName'],
      likeCount: json['likeCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      imageUrl: json['imageUrl'],
    );
  }
}
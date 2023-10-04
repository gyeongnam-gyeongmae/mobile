class CommentModel{
  final int id;
  final String content;
  final int userId;
  final String nickName;
  final int likeCount;
  final DateTime createdAt;
  final List<CommentModel> children;

  CommentModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.nickName,
    required this.createdAt,
    required this.likeCount,
    required this.children
  });

  factory CommentModel.fromJson(Map<String, dynamic> json){
    final List<CommentModel> childrenList = (json['children']as List<dynamic>?)
      ?.map((childJson) => CommentModel.fromJson(childJson))
      .toList() ?? [];
    
    return CommentModel(
      id: json['id'],
      content: json['content'],
      userId: json['userId'],
      nickName: json['nickName'],
      likeCount: json['likeCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      children: childrenList,
    );
  }
}
import 'package:mobile/model/big_comment_model.dart';

class CommentModel{
  final int id;
  final String content;
  final int userId;
  final String nickName;
  final int likeCount;
  final DateTime createdAt;
  final List<BigCommentModel> children;
  final bool isLiked;
  final String imageUrl;

  CommentModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.nickName,
    required this.createdAt,
    required this.likeCount,
    required this.children,
    required this.isLiked,
    required this.imageUrl
  }); 

  factory CommentModel.fromJson(Map<String, dynamic> json){
    final List<BigCommentModel> childrenList = (json['children']as List<dynamic>?)
      ?.map((childJson) => BigCommentModel.fromJson(childJson))
      .toList() ?? [];
    
    return CommentModel(
      id: json['id'],
      content: json['content'],
      userId: json['userId'],
      nickName: json['nickName'],
      likeCount: json['likeCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      children: childrenList,
      isLiked: json['isLiked'],
      imageUrl: json['imageUrl'],
    );
  }
}
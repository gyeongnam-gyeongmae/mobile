class RemoveCommentModel {
  final int userId;
  final int commentId;

  RemoveCommentModel({
    required this.userId,
    required this.commentId
  });

  Map<String, dynamic> toJson(){
    return {
      'userId' : userId,
      'commentId' : commentId,
    };
  }
}
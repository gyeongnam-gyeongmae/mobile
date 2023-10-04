class WriteCommentModel {
  final String content;
  final int userId;
  final int parentCommentId;

  WriteCommentModel({
    required this.content,
    required this.userId,
    required this.parentCommentId
  });

  Map<String, dynamic> toAddJson(){
    return {
      'content' : content,
      'userId' : userId,
      'parentCommentId' : parentCommentId,
    };
  }

  Map<String, dynamic> toEditJson(){
    return {
      'content' : content,
      'userId' : userId,
      'commentId' : parentCommentId,
    };
  }
}
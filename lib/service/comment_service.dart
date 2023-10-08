
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/model/comment_model.dart';
import 'package:mobile/model/remove_comment_model.dart';
import 'package:mobile/model/write_comment_model.dart';


class CommentService{
  final String baseUrl;

  CommentService(this.baseUrl);

  Future<List<CommentModel>> getCommentList(int id) async{
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    print(response.statusCode);
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((comment) => CommentModel.fromJson(comment)).toList();
    } else {
      throw Exception('commentService 오류');
    }
  }

  Future<String> writeComment(WriteCommentModel comment,int id) async{
    final response = await http.post(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(comment.toAddJson())
    );
    if(response.statusCode == 201){
      return "$id 댓글 추가";
    }
    else { throw Exception('commentService write 오류');}
  }

  Future<String> removeComment(int userId, int commentId) async{
    final response = await http.delete(
      Uri.parse('$baseUrl?userId=$userId&commentId=$commentId'),
    );
    if(response.statusCode == 200){
      return "$commentId 댓글 삭제";
    }
    else { throw Exception('commentService remove 오류');}
  }

  Future<String> editComment(WriteCommentModel comment) async{
    final response = await http.patch(
      Uri.parse('$baseUrl'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(comment.toEditJson())
    );
    if(response.statusCode == 200){
      return "댓글 수정";
    }
    else { throw Exception('commentService edit 오류');}
  }
}
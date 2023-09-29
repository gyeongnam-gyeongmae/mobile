
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/model/comment_model.dart';


class CommentService{
  final String baseUrl;

  CommentService(this.baseUrl);

  Future<List<CommentModel>> getCommentList(int id) async{
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((comment) => CommentModel.fromJson(comment)).toList();
    } else {
      throw Exception('commentService 오류');
    }
  }
}
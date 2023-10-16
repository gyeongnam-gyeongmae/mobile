import 'dart:convert';

import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/model/user_profile_model.dart';
import 'package:http/http.dart' as http;

class UserProfileService{
  final String baseUrl = "http://203.241.228.51:5000/api/authentications/profile";
  Future<UserProfileModel> getUserProfile() async{
    final response = await http.get(Uri.parse(baseUrl),
      headers: 
      {
        'Cookie' : await ProfileController.to.getCookies(baseUrl),
      }
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return UserProfileModel.fromJson(data);
    } else {
      print(response.statusCode);
      throw Exception('ProductDetailService 오류발생');
    }
  }
}
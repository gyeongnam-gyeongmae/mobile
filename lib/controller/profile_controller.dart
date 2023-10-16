import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile/services/map_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  int id = 0;
  String nickName = "";
  final CookieJar cookieJar = CookieJar(); // CookieJar 인스턴스 생성
  String imageUrl ="";
  
  void setId(int userId){
    id = userId;
  }
  void setNickname(String nickname){
    nickName = nickname;
  }
  void setImageUrl(String imageUrl){
    this.imageUrl = imageUrl;
  }

  String getImageUrl(){
    return imageUrl;  
  }

  int getId(){
    return id;
  }

  String getNickname(){
    return nickName;
  }

  Future<String> getCookies(String baseUrl) async{
    //-----
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString("JSESSIONID");
    final sessionValue = extractSessionFromCookie(cookie!);
      if (sessionValue == null) {
        throw Exception('세션 쿠키에서 SESSION 값을 찾을 수 없습니다.');
      }

      final uri = Uri.parse("http://203.241.228.51:5000");
      final sessionCookie = Cookie('SESSION', sessionValue);
      await cookieJar.saveFromResponse(uri, [sessionCookie]);

      // 저장한 쿠키를 요청 헤더에 추가하여 HTTP 요청 보내기
      final url = Uri.parse('$baseUrl');
      final cookies = await cookieJar.loadForRequest(url);
      return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }

  static ProfileController get to => Get.find();

}


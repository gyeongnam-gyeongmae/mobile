import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/map_service.dart';
import 'package:mobile/views/pages/join/phone_page.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/views/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Rename the import prefix

class JoinService {
  // Rename the local variable to avoid conflicts
  final http.Client httpClient = http.Client();

  final String baseUrl = 'http://203.241.228.51:5000/api';

  Future<void> sendPhoneVerificationRequest(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/authentications/phone');

    // 요청 본문 데이터 설정

    final response = await httpClient.post(
      url,
      body: jsonEncode({'phoneNumber': phoneNumber}), // JSON 형식으로 데이터 보내기
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      print('요청이 성공했습니다: ${response.body}');
      print("라우팅할게요");
      Get.to(() => const PhonePage());
    } else {
      // 오류 응답 처리
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
  }

  Future<void> getPhoneVerificationRequest(
      String phoneNumber, String code) async {
    final url = Uri.parse(
        '$baseUrl/authentications/phone?phoneNumber=$phoneNumber&&code=$code');
    final response = await httpClient.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      print('요청이 성공했습니다1: ${response.body}');
    } else {
      // 오류 응답 처리
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
  }

  Future<void> register(
    String phoneNumbers,
    String authenticationNumber,
    String vendorAccessToken,
  ) async {
    final url = Uri.parse('$baseUrl/authentications/register/KAKAO');
    final response = await httpClient.post(
      url,
      body: jsonEncode({
        'vendorAccessToken': vendorAccessToken,
        'phoneNumber': phoneNumbers,
        'phoneAuthenticationCode': authenticationNumber,
      }), // JSON 형식으로 데이터 보내기
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      final headers = response.headers;
      final cookies = headers['set-cookie'];
      print("쿠기는$cookies");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("JSESSIONID", cookies!);
      Get.to(() => const MainPage());
    } else {
      // 오류 응답 처리
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
  }

  Future<void> profile() async {
    final controller = Get.find<ProfileController>();

    final http.Client httpClient = http.Client();

    const String baseUrl = 'http://203.241.228.51:5000';
    final CookieJar cookieJar = CookieJar(); // CookieJar 인스턴스 생성

    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString("JSESSIONID");

    final sessionValue = extractSessionFromCookie(cookie!);
    if (sessionValue == null) {
      throw Exception('세션 쿠키에서 SESSION 값을 찾을 수 없습니다.');
    }

    print(sessionValue);
    print(cookie);

    final uri = Uri.parse(baseUrl);
    final sessionCookie = Cookie('SESSION', sessionValue);
    await cookieJar.saveFromResponse(uri, [sessionCookie]);

    // 저장한 쿠키를 요청 헤더에 추가하여 HTTP 요청 보내기
    final url = Uri.parse('$baseUrl/api/authentications/profile');
    final cookies = await cookieJar.loadForRequest(url);
    final cookieHeader =
        cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');

    final response = await httpClient.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode == 200) {
      // 서버 응답을 반환
      final Map<String, dynamic> responseData =
          jsonDecode(utf8.decode(response.bodyBytes));
      final User user = User.fromJson(responseData);

      final prefs = await SharedPreferences.getInstance();

      prefs.setInt("id", user.id);
      prefs.setString("nickname", user.nickname);
      print('id: $user.id');
      controller.id = user.id;
      controller.nickName = user.nickname;
    } else {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt("id");

      final uri = Uri.parse(baseUrl);

      // 저장한 쿠키를 요청 헤더에 추가하여 HTTP 요청 보내기
      final url = Uri.parse('$baseUrl/api/authentications/$id/session');

      final response = await httpClient.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        print("4");
        // 서버 응답을 반환

        final headers = response.headers;

        final cookies = headers['set-cookie'];

        print("쿠기는$cookies");

        prefs.setString("JSESSIONID", cookies!);
      }
    }
  }
}

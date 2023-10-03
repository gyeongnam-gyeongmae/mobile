import 'dart:convert';

import 'package:get/get.dart';
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
      Get.to(() => MainPage());
    } else {
      // 오류 응답 처리
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
  }
}

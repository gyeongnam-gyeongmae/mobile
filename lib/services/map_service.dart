import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/map_model.dart';

class MapService {
  final http.Client httpClient = http.Client();

  String baseUrl = 'http://203.241.228.51:5000';
  final CookieJar cookieJar = CookieJar(); // CookieJar 인스턴스 생성

  Future<MapModel?> postLocation(Position position, String cookie) async {
    final sessionValue = extractSessionFromCookie(cookie);
    if (sessionValue == null) {
      throw Exception('세션 쿠키에서 SESSION 값을 찾을 수 없습니다.');
    }

    final uri = Uri.parse(baseUrl);
    final sessionCookie = Cookie('SESSION', sessionValue);
    await cookieJar.saveFromResponse(uri, [sessionCookie]);

    final url = Uri.parse('$baseUrl/api/users/address');
    final cookies = await cookieJar.loadForRequest(url);
    final cookieHeader =
        cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');

    final requestBody = jsonEncode({
      'latitude': 34.8806,
      'longitude': 128.6211,
    });

    final response = await httpClient.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      // 서버 응답을 반환
      print("성공!!!!!!!!!!");

      final Map<String, dynamic> responseData =
          jsonDecode(utf8.decode(response.bodyBytes));
      final MapModel map = MapModel.fromJson(responseData);

      print(map);
      return map;
    } else {
      // 오류 응답 처리
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
    return null;
  }
}

String? extractSessionFromCookie(String cookieString) {
  final sessionMatch = RegExp(r'SESSION=([^;]+)').firstMatch(cookieString);
  if (sessionMatch != null) {
    return sessionMatch.group(1);
  }
  return null;
}

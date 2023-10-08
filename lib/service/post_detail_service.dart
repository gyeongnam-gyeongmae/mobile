import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailService {
  final String baseUrl;
  final CookieJar cookieJar = CookieJar(); // CookieJar 인스턴스 생성
  ProductDetailService(this.baseUrl);

  Future<ProductDetailModel> getProductDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return ProductDetailModel.fromJson(data);
    } else {
      throw Exception('ProductDetailService 오류발생');
    }
  }

  Future<String> removeProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return "삭제 성공";
    } else {
      throw Exception('ProductDetailService 삭제 오류발생');
    }
  }

  Future<void> changeLike(int userId) async {
    final response = await http.post(Uri.parse("$baseUrl/$userId/like"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'userId': userId}));
    if (response.statusCode == 200) {
      print("좋아요 됨");
    } else {
      print(response.statusCode);
      print("$baseUrl/$userId/like");
    }
  }

  Future<String> addPrice(int id, int price) async {
    //-----
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString("JSESSIONID");
    try {
      final sessionValue = extractSessionFromCookie(cookie!);
      if (sessionValue == null) {
        throw Exception('세션 쿠키에서 SESSION 값을 찾을 수 없습니다.');
      }
      print(sessionValue);
      print(cookie);
      print(price);

      final uri = Uri.parse("http://203.241.228.51:5000");
      final sessionCookie = Cookie('SESSION', sessionValue);
      await cookieJar.saveFromResponse(uri, [sessionCookie]);

      // 저장한 쿠키를 요청 헤더에 추가하여 HTTP 요청 보내기
      final url = Uri.parse('$baseUrl/$id/bids');
      final cookies = await cookieJar.loadForRequest(url);
      final cookieHeader =
          cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      //------

      // 저장한 쿠키를 요청 헤더에 추가하여 HTTP 요청 보내기

      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookieHeader,
          },
          body: jsonEncode({'price': price}));
      if (response.statusCode == 201) {
        print("입찰됨");
        return "입찰성공";
      } else
        print(response.statusCode);
        print(response.body);
    } catch (e) {
      print("addProductService addPrice 오류 $e");
    }
    return "실패";
  }

  String? extractSessionFromCookie(String cookieString) {
    final sessionMatch = RegExp(r'SESSION=([^;]+)').firstMatch(cookieString);
    if (sessionMatch != null) {
      return sessionMatch.group(1);
    }
    return null;
  }
}

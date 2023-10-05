import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailService{
    final String baseUrl;
    final CookieJar cookieJar = CookieJar(); // CookieJar 인스턴스 생성
    ProductDetailService(this.baseUrl);

    Future<ProductDetailModel> getProductDetail(int id) async{
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if(response.statusCode == 200){
        final data = json.decode(utf8.decode(response.bodyBytes));
        return ProductDetailModel.fromJson(data);
      } else {
        throw Exception('ProductDetailService 오류발생');
      }
    }

    Future<String> removeProduct(int id) async{
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if(response.statusCode == 200){
        return "삭제 성공";
      } else {
        throw Exception('ProductDetailService 삭제 오류발생');
      }
    }

    Future<void> changeLike(int userId) async{
      final response = await http.post(
      Uri.parse("$baseUrl/$userId/like"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'userId' : userId}));
      if(response.statusCode == 200){ print("좋아요 됨");}
      else {
        print(response.statusCode);
        print("$baseUrl/$userId/like");
      }
    }

    Future<String> addPrice(int id, int price) async{
    try{
      // 저장한 쿠키를 요청 헤더에 추가하여 HTTP 요청 보내기
      final cookie = 'ZGQ4NzQ2NzgtNmFjNS00YTE3LTg2ZWYtMTFhNGFiMTE2MWU5';
      final response = await http.post(
      Uri.parse("$baseUrl/$id/bids"),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': cookie!,
      },
      body: jsonEncode(jsonEncode({'price' : price}))
    );
    if(response.statusCode == 201){
      print("입찰됨");
      return "입찰성공";
    } else print(response.statusCode);
    }catch (e){ print("addProductService addPrice 오류 $e");}
    return "실패";
    }
}
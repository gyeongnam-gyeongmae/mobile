import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:mobile/model/product_page.dart';
import 'package:mobile/model/product_page_info.dart';

class ProductService{
  final String baseUrl;

  ProductService(this.baseUrl);

  Future<ProductPage> fetchProductItems(int page) async {
    try{
      final response = await http.get(Uri.parse('$baseUrl?page=$page'));
      if(response.statusCode == 200){
        final data = json.decode(utf8.decode(response.bodyBytes));
        return ProductPage.fromJson(data);
      } else{
        throw Exception('옥션 페이지로드 실패');
      }
    }catch (e){
      throw Exception('옥션 페이지 로드 실패');
    }
  }

  String changeDatetime(DateTime time){
    DateTime now = DateTime.now();

    //분 단위 현재시각과의 차이
    int differenceMinutes = time.difference(now).inMinutes;

    String timeDifference;
    if(differenceMinutes < 60){
      timeDifference = '$differenceMinutes분 전';
    } else {
      int hours = differenceMinutes ~/ 60;
      int minutes = differenceMinutes % 60;
      timeDifference = '$hours시간 $minutes분 전';
    }
    return timeDifference;
  }
}
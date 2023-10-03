import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile/model/add_product_model.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/model/product_page.dart';
import 'package:mobile/model/product_page_info.dart';

class ProductService{
  final String baseUrl;

  ProductService(this.baseUrl);

  Future<ProductPage> fetchProductItems(int page, ProductSearchModel postSearchModel) async {
    try{
      // final response = await http.get(Uri.parse('$baseUrl?page=$page'));
      final response = await http.get(Uri.parse("$baseUrl?keyword=${postSearchModel.keyword}&category=${postSearchModel.category}&nick_name=${postSearchModel.nick_name}&closed=${postSearchModel.closed}&search_time=${postSearchModel.search_time}&like=${postSearchModel.like}&search_price=${postSearchModel.search_price}&page=$page"));
      if(response.statusCode == 200){
        final data = json.decode(utf8.decode(response.bodyBytes));
        return ProductPage.fromJson(data);
      } else{
        throw Exception('옥션 페이지로드 실패');
      }
    }catch (e){
      throw Exception(e.toString() + '프로덕트 서비스에서 오류');
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
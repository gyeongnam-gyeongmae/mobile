import 'dart:convert';

import 'package:mobile/model/add_product_model.dart';
import 'package:http/http.dart' as http;

class AddProductService{
  final String url = 'http://203.241.228.51:5000/api/auctions/';

  Future<String> addProduct(AddProductModel product) async{
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(product.toJson())
    );
    print(url);
    print(response.body);
    if(response.statusCode == 201){
      return "경매품 추가";
    }
    else { throw Exception('addProductService 오류');}
  }
}
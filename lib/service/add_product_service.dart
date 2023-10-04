import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/add_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddProductService{
  final String url = 'http://203.241.228.51:5000/api/auctions/';
  final String imageUrl = 'http://203.241.228.51:5000/api/AuctionItem/';

  Future<String> addProduct(AddProductModel product,List<XFile?> images) async{
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(product.toJson())
    );
    if(response.statusCode == 201){
      await uploadImage(images, 31);
      return "경매품 추가";
    }
    else { throw Exception('addProductService 오류');}
  }

  Future<String> uploadImage(List<XFile?> images,int productId) async{
    final List<MultipartFile> files = images
        .map((image) => MultipartFile.fromFileSync(image!.path,
        contentType: MediaType('image', 'jpeg'))).toList();
    final formData = FormData.fromMap({'file':files});
    final response = await Dio().post(
      '$imageUrl$productId/images/upload',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data'
      )
    );


    if(response.statusCode == 200){
      return "이미지 업로드됨";
    }else { throw Exception('addProductService 이미지 업로드 오류');}
  }
}
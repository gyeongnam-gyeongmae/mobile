import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/model/add_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddProductService{
  final String url = 'http://203.241.228.51:5000/api/auctions/';
  final String imageUrl = 'http://203.241.228.51:5000/api/AuctionItem/';
  final String profileUrl = 'http://203.241.228.51:5000/api/Profile/';

  Future<int> addProduct(AddProductModel product,List<XFile?> images) async{
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(product.toJson())
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final int id = responseData['id'];
      print(id);
      await uploadImage(images, id);
      return id;
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

  Future<String> uploadProfileImage(List<XFile?> images,int userId) async{
    final List<MultipartFile> files = images
        .map((image) => MultipartFile.fromFileSync(image!.path,
        contentType: MediaType('image', 'jpeg'))).toList();
    final formData = FormData.fromMap({'file':files});
    final response = await Dio().post(
      '$profileUrl$userId/images/upload',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {
          'Cookie' : ProfileController.to.getCookies('$profileUrl$userId/images/upload')
        },
      )
    );


    if(response.statusCode == 200){
      return "이미지 업로드됨";
    }else { throw Exception('addProductService 이미지 업로드 오류');}
  }
}
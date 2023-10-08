import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile/model/add_product_model.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/model/product_page.dart';
import 'package:mobile/model/product_page_info.dart';
import 'package:mobile/model/user_search_model.dart';

class ProductService {
  final String baseUrl;
  final String profileUrl = "http://203.241.228.51:5000/api/users/profile/";

  ProductService(this.baseUrl);

  Future<ProductPage> fetchProductItems(
      int page, ProductSearchModel postSearchModel) async {
    try {
      // final response = await http.get(Uri.parse('$baseUrl?page=$page'));
      final response = await http.get(Uri.parse(
          "$baseUrl?keyword=${postSearchModel.keyword}&category=${postSearchModel.category}&nick_name=${postSearchModel.nick_name}&closed=${postSearchModel.closed}&search_time=${postSearchModel.search_time}&like=${postSearchModel.like}&search_price=${postSearchModel.search_price}&basic=${postSearchModel.basic}&page=$page"));
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        return ProductPage.fromJson(data);
      } else {
        throw Exception('옥션 페이지로드 실패');
      }
    } catch (e) {
      throw Exception(e.toString() + '프로덕트 서비스에서 오류');
    }
  }

  Future<ProductPage> fetchUsersellItems(
      int page, ProductSearchModel postSearchModel) async {
    try {
      final response = await http.get(Uri.parse(
          "${profileUrl}2/auctionItems?closed=${postSearchModel.closed}&page=$page"));
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        return ProductPage.fromJson(data);
      } else {
        throw Exception('옥션 페이지로드 실패');
      }
    } catch (e) {
      throw Exception(e.toString() + '프로덕트 서비스 유저 물품 조회 에서 오류');
    }
  }

  Future<ProductPage> fetchUserbuyItems(
      int page) async {
    try {
      final response = await http.get(Uri.parse(
          "${profileUrl}2/auctionItems/buy?page=$page"));
          print("${profileUrl}3/auctionItems/buy?page=$page");
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        return ProductPage.fromJson(data);
      } else {
        throw Exception('옥션 페이지로드 실패');
      }
    } catch (e) {
      throw Exception(e.toString() + '프로덕트 서비스 유저 물품 조회 에서 오류');
    }
  }

  Future<ProductPage> fetchUserLikeItems(
      int page) async {
    try {
      final response = await http.get(Uri.parse(
          "${profileUrl}liked/2?page=$page"));
          print("${profileUrl}2/liked?page=$page");
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        return ProductPage.fromJson(data);
      } else {
        throw Exception('옥션 페이지로드 실패');
      }
    } catch (e) {
      throw Exception(e.toString() + '프로덕트 서비스 유저 물품 조회 에서 오류');
    }
  }


  String changeDatetime(DateTime time) {
    final now = DateTime.now();
    final dateTime = time.add(Duration(hours: 9)); //서버는 미국시간 기준이어서 9시간 더하기
    final difference = dateTime.difference(now); // 차이 계산
    if (difference.inDays >= 1) {
      final days = difference.inDays;
      return '마감 $days일 전';
    } else if (difference.inHours > 1) {
      final hours = difference.inHours;
      return '마감 $hours시간 전';
    } else if (difference.inHours == 1) {
      return '마감 1시간 전';
    } else if (difference.inMinutes >= 1) {
      return '마감 ${difference.inMinutes}분 전';
    } else{
      return '경매 마감';
    }
  }
}

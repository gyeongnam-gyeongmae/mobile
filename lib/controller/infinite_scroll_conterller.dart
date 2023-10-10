import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/model/product_page.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/model/product_item.dart';
import 'package:mobile/service/post_detail_service.dart';
import 'package:mobile/service/product_service.dart';

class InfiniteScrollController extends GetxController {
  final ProductService productService =
      ProductService("http://203.241.228.51:5000/api/auctions/search");
  final ProductDetailService productDetailService =
      ProductDetailService("http://203.241.228.51:5000/api/auctions");
  var scrollController = ScrollController().obs;
  var data = <ProductItem>[].obs;
  final ProductSearchModel searchData;
  var isLoading = false.obs;
  var hasMore = false.obs;
  var maxItemLength = 0.obs;
  String mode = "all"; //mode, user
  int currentPage = 1;
  RxBool isLike = false.obs;

  InfiniteScrollController({required this.searchData, required this.mode});
  @override
  void onInit() {
    _getData();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    super.onClose();
  }

  _getData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 200));

    try {
      ProductPage item;
      if(mode == "all"){
        item = await productService.fetchProductItems(currentPage, searchData,ProfileController.to.getId());//userId
      } else if(mode == "user"){
        item = await productService.fetchUsersellItems(currentPage, searchData);
      } else if(mode == "buy"){
        item = await productService.fetchUserbuyItems(currentPage);
      } else if(mode == "like"){
        item = await productService.fetchUserLikeItems(currentPage);
      }
      else {
        item = await productService.fetchProductItems(currentPage, searchData,ProfileController.to.getId());//userId
      }
      
      maxItemLength.value = item.productPageInfo.totalItems;
      currentPage++;
      data.addAll(item.auctionItemFirstViewPage);
    } catch (e) {
      print(e.toString());
    }

    isLoading.value = false;
    hasMore.value = data.length < maxItemLength.value;
  }

  reload() async {
    isLoading.value = true;
    currentPage = 1;
    data.clear();

    await Future.delayed(const Duration(milliseconds: 200));

    _getData();
  }

  String changeTime(int index) {
    return productService.changeDatetime(data[index].closedTime);
  }
  

  Future<ProductDetailModel> getProductDetail(int id) async {
    ProductDetailModel productDetailModel =
        await productDetailService.getProductDetail(id);
    return productDetailModel;
  }

  Future<String> removeProduct(int id) async {
    return await productDetailService.removeProduct(id);
  }

  Future<String> addPrice(int id, int price) async{
    return productDetailService.addPrice(id, price);
  }

  Future<void> changeLike(int postId) async{
    productDetailService.changeLike(postId,ProfileController.to.getId());
  }

  void setCategory(String category){
    searchData.category = category;
  }
}

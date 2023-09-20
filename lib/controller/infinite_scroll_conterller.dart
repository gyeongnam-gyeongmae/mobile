import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mobile/model/product_item.dart';
import 'package:mobile/service/product_service.dart';

class InfiniteScrollController extends GetxController {
  final ProductService productService = ProductService("http://203.241.228.51:5000/api/auctions/search");
  var scrollController = ScrollController().obs;
  var data = <ProductItem>[].obs;
  var isLoading = false.obs;
  var hasMore = false.obs;
  var maxItemLength = 0.obs;
  int currentPage = 1;

  @override
  void onInit() {
    _getData();
    this.scrollController.value.addListener(() {
      if (this.scrollController.value.position.pixels ==
              this.scrollController.value.position.maxScrollExtent &&
          this.hasMore.value) {
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

    await Future.delayed(Duration(milliseconds: 200));

    try{
      final item = await productService.fetchProductItems(currentPage);
      maxItemLength.value = item.productPageInfo.totalItems;
      currentPage++;
      data.addAll(item.auctionItemFirstViewPage);
    } catch (e) { throw Exception('scroll controller error');}

    isLoading.value = false;
    hasMore.value = data.length < maxItemLength.value;
  }
  reload() async {
    isLoading.value = true;
    currentPage = 1;
    data.clear();

    await Future.delayed(Duration(milliseconds: 200));

    _getData();
  }

  String changeTime(int index){
    return productService.changeDatetime(data[index].closedTime);
  }
}

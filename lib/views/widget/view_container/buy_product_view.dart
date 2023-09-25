import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/views/widget/view_container/infinite_scroll_view.dart';

class BuyProductView extends StatelessWidget {

  BuyProductView({super.key});
  late InfiniteScrollController controller;
  Widget _containerSelector(BuildContext context,int cnt) {
    Get.delete<InfiniteScrollController>();
    controller = Get.put(InfiniteScrollController(searchData: ProductSearchModel(
      keyword: "", category: "",
      nick_name: "", closed: false,
      search_time: true, like: true,
      search_price: true)));
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, left: 25),
              child: Text('상품 $cnt건',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Divider(color: Colors.grey, thickness: 1),
            )
          ],
        ));
  }
  Widget _buildContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Container(child: InfiniteScrollView(controller: controller,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
          _containerSelector(context, 0),
          Expanded(child: _buildContainer())],
        );
  }
}
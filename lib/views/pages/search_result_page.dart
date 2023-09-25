import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/dropdown_controller.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/search_textfield_controller.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/bar/search_appbar.dart';
import 'package:mobile/views/widget/dropdown/popular_dropdown.dart';
import 'package:mobile/views/widget/dropdown/price_dropdown.dart';
import 'package:mobile/views/widget/dropdown/sell_bool_dropdown.dart';
import 'package:mobile/views/widget/view_container/infinite_scroll_view.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key});
  final SearchTextfieldController searchController = Get.find<SearchTextfieldController>();
  final DropdownController dropdownController = Get.find<DropdownController>();
  @override
  Widget build(BuildContext context) {
    //바텀바의 get.to를 쓰기위한 방법
    return Scaffold(
      appBar: SearchAppbar(),
      body: Obx(() {
        Get.delete<InfiniteScrollController>();
                final content = searchController.content.value;
                InfiniteScrollController controller = Get.put(
                      InfiniteScrollController(
                          searchData: ProductSearchModel(
                              keyword: content,
                              category: "",
                              nick_name: "",
                              closed: dropdownController.sellBool.value,
                              search_time: true,
                              like: dropdownController.popularBool.value,
                              search_price: dropdownController.priceBool.value
                              )));
        return Column(
        children: [
          // Container(margin: EdgeInsets.only(right: 40),child: SearchTextfield(content: "삼성 카메라"),),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PopularDropdown(items: ['인기 많은순', '인기 적은순']),
                PriceDropdown(items: ['가격 높은순', '가격 낮은순']),
                SellBoolDropdown(items: ['판매중', '판매완료'])
              ],
            ),
          ),
          Expanded(
              child: InfiniteScrollView(
                controller: controller,
          ))
        ],
      );
      }),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}

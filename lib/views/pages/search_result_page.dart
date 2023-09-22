import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
<<<<<<< HEAD
import 'package:mobile/views/widget/bar/saerch_appbar.dart';

=======
import 'package:mobile/views/widget/bar/search_appbar.dart';
>>>>>>> develop
import 'package:mobile/views/widget/dropdown/popular_dropdown.dart';
import 'package:mobile/views/widget/dropdown/price_dropdown.dart';
import 'package:mobile/views/widget/textfield/search_textfield.dart';
import 'package:mobile/views/widget/dropdown/sell_bool_dropdown.dart';
import 'package:mobile/views/widget/view_container/infinite_scroll_view.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key});
  InfiniteScrollController controller = Get.put(InfiniteScrollController());
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    Get.delete<InfiniteScrollController>();
    controller = Get.put(InfiniteScrollController());
    return Scaffold(
      appBar: const SearchAppbar(),
=======

    Get.delete<InfiniteScrollController>();
    controller = Get.put(InfiniteScrollController());
    return Scaffold(
      appBar: SearchAppbar(),
>>>>>>> develop
      body: Column(
        children: [
          // Container(margin: EdgeInsets.only(right: 40),child: SearchTextfield(content: "삼성 카메라"),),
          Container(
<<<<<<< HEAD
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PopularDropdown(items: const ['인기 많은순', '인기 적은순']),
                PriceDropdown(items: const ['가격 높은순', '가격 낮은순']),
                SellBoolDropdown(items: const ['판매중', '판매완료'])
=======
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PopularDropdown(items: ['인기 많은순', '인기 적은순']),
                PriceDropdown(items: ['가격 높은순', '가격 낮은순']),
                SellBoolDropdown(items: ['판매중', '판매완료'])
>>>>>>> develop
              ],
            ),
          ),
          Expanded(
              child: InfiniteScrollView(
<<<<<<< HEAD
            controller: controller,
=======
                controller: controller,
>>>>>>> develop
          ))
        ],
      ),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}

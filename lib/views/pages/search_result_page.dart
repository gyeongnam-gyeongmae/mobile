import 'package:flutter/material.dart';
import 'package:mobile/views/widget/infinite_scroll_view.dart';
import 'package:mobile/views/widget/main_bottom_bar.dart';
import 'package:mobile/views/widget/main_appbar.dart';
import 'package:mobile/views/widget/popular_dropdown.dart';
import 'package:mobile/views/widget/price_dropdown.dart';
import 'package:mobile/views/widget/search_appbar.dart';
import 'package:mobile/views/widget/search_textfield.dart';
import 'package:mobile/views/widget/sell_bool_dropdown.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppbar(),
      body: Column(
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
          Expanded(child: InfiniteScrollView())
        ],
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/tabbar_controller.dart';
import 'package:mobile/views/widget/buy_product_view.dart';
import 'package:mobile/views/widget/sell_product_view.dart';

class InfoTabbar extends GetView<TabbarController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10,left: 10),
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            indicatorColor: Colors.brown,
            dividerColor: Colors.blue,
            labelColor: Colors.black,
            controller: controller.tabController,
            tabs: controller.myTabs,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6, // 높이를 지정
          child: Column(
            children: [
              // 다른 위젯들을 추가할 수 있음
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    SellProductView(),
                    BuyProductView(),
                    BuyProductView(),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/tabbar_controller.dart';
import 'package:mobile/views/widget/view_container/like_product_view.dart';
import 'package:mobile/views/widget/view_container/sell_product_view.dart';
import 'package:mobile/views/widget/view_container/buy_product_view.dart';

class InfoTabbar extends GetView<TabbarController> {
  const InfoTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10),
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            indicatorColor: Colors.brown,
            dividerColor: Colors.blue,
            labelColor: Colors.black,
            controller: controller.tabController,
            tabs: controller.myTabs,
            onTap: (index) {
              if (index == 0) {
                Get.find<InfiniteScrollController>(tag: "sellAllPage").reload();
              } else if (index == 1) {
                Get.find<InfiniteScrollController>(tag: "buyPage").reload();
              } else if (index == 2) {
                Get.find<InfiniteScrollController>(tag: "likePage").reload();
              }
            },
          ),
        ),
        SizedBox(
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
                    LikeProductView(),
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

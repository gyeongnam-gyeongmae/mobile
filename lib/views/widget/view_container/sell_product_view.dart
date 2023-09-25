import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/sell_product_controller.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/views/widget/view_container/infinite_scroll_view.dart';

class SellProductView extends GetView<SellProductController> {
  late List<Widget> myContainers;
  late InfiniteScrollController scrollController;
  //내정보 페이지에서 버튼 클릭시 아래에 표시할 컨테이너, 위젯list로 관리하면 될듯
  Widget _buildContainer() {
    Get.delete<InfiniteScrollController>();
    scrollController = Get.put(InfiniteScrollController(searchData: ProductSearchModel(
      keyword: "", category: "",
      nick_name: "", closed: false,
      search_time: true, like: true,
      search_price: true)));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Container(child: InfiniteScrollView(controller: scrollController)),
    );
  }

  //판매 상품에 만들어진 버튼 디자인
  Widget _containerSelectorButton(int id, String text) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor:
                id == controller.selectedId.value ? Colors.black : Colors.white,
            foregroundColor:
                id == controller.selectedId.value ? Colors.white : Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        onPressed: () {
          controller.setSelectedId(id);
        },
        child: Text(text));
  }

  //버튼 생성
  Widget _containerSelector(BuildContext context, int cnt) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _containerSelectorButton(0, '전체'),
                    _containerSelectorButton(1, '판매중'),
                    _containerSelectorButton(2, '판매완료'),
                  ]),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 25),
              child: Text('상품 $cnt건',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Divider(color: Colors.grey, thickness: 1),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            _containerSelector(context, 0),
            Expanded(child: _buildContainer())
          ],
        ));
  }
}

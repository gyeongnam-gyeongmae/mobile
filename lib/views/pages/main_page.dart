import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/join_controller.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/infinite_scroll_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    final JoinController joinController = Get.find<JoinController>();
    joinController.profile();
    Get.delete<InfiniteScrollController>();
    InfiniteScrollController controller = Get.put(InfiniteScrollController(searchData: ProductSearchModel(
      keyword: "", category: "",
      nick_name: "", closed: "ALL",
      search_time: true, like: true,
      search_price: true, basic: true)));
    return Scaffold(
      appBar: const MainAppbar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          controller.setCategory('의류');
                          controller.reload();
                        },
                        child: const Text('의류')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          controller.setCategory('디지털');
                          controller.reload();
                        },
                        child: const Text('디지털')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          controller.setCategory('디지털');
                          controller.reload();
                        },
                        child: const Text('가구')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          controller.setCategory('기타');
                          controller.reload();
                        },
                        child: const Text('기타')),
                  )
                ]),
          ),
          Expanded(
              child: InfiniteScrollView(
            controller: controller,
          )),
        ],
      ),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}

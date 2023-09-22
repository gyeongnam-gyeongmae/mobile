import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/infinite_scroll_view.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final InfiniteScrollController controller =
      Get.put(InfiniteScrollController());
  @override
  Widget build(BuildContext context) {
    // if (Get.isRegistered<InfiniteScrollController>(tag: "chat")) {
    //   Get.find<InfiniteScrollController>(tag: "chat").onClose();
    // }
    // if (Get.isRegistered<InfiniteScrollController>(tag: "info")) {
    //   Get.find<InfiniteScrollController>(tag: "info").onClose();
    // }
    return Scaffold(
      appBar: MainAppbar(),
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
                        onPressed: () {},
                        child: const Text('의류')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {},
                        child: const Text('디지털')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {},
                        child: const Text('가구')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {},
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

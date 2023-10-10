import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';

import 'package:mobile/controller/join_controller.dart';
import 'package:mobile/controller/profile_image_controller.dart';
import 'package:mobile/model/product_search_model.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/infinite_scroll_view.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime? currentBackPressTime;
  late InfiniteScrollController controller; // 컨트롤러 선언 수정

  @override
  void initState() {
    super.initState();
    final JoinController joinController = Get.find<JoinController>();
    joinController.profile();
    Get.delete<InfiniteScrollController>();
    controller = Get.put(InfiniteScrollController(
      searchData: ProductSearchModel(
        keyword: "",
        category: "",
        nick_name: "",
        closed: "ALL",
        search_time: true,
        like: true,
        search_price: true,
        basic: true,
      ),
      mode: "all",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(),
      bottomNavigationBar: const MainBottomBar(),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Column(
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        controller.setCategory('의류');
                        controller.reload();
                      },
                      child: const Text('의류'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        controller.setCategory('디지털');
                        controller.reload();
                      },
                      child: const Text('디지털'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        controller.setCategory('디지털');
                        controller.reload();
                      },
                      child: const Text('가구'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        controller.setCategory('기타');
                        controller.reload();
                      },
                      child: const Text('기타'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: InfiniteScrollView(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
        ),
      );
      return false;
    }

    // 시스템 종료
    SystemNavigator.pop(); // 이 부분을 추가하여 앱을 시스템 종료로 종료합니다.
    return true;
  }
}

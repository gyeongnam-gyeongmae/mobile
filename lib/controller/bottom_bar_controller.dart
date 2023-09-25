import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/views/pages/info_page.dart';
import 'package:mobile/views/pages/login_page.dart';
import 'package:mobile/views/pages/main_page.dart';
import 'package:mobile/views/pages/post_add_page.dart';
import 'package:mobile/views/pages/search_result_page.dart';

class BottomBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
      
  void changePage(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.to(MainPage());
        break;
      case 1:
        Get.to(PostAddPage());
        break;
      case 2://채팅내역으로 바꿔야함
        break;
      case 3:
        Get.to(InfoPage());
        break;
      default: break;
    }
  }
}

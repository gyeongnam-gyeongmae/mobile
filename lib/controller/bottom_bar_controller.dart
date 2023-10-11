import 'package:get/get.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/sse_controller.dart';
import 'package:mobile/views/pages/chatting/chatting.dart';
import 'package:mobile/views/pages/info_page.dart';
import 'package:mobile/views/pages/main_page.dart';
import 'package:mobile/views/pages/post_add_page.dart';
import 'package:mobile/views/pages/search_result_page.dart';

class BottomBarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    SseController.to.disconnect();
    switch (index) {
      case 0:
        InfiniteScrollController controller =
            Get.find<InfiniteScrollController>(tag: "mainPage");
        controller.setCategory("");
        controller.reload();
        update();
        Get.to(() => const MainPage());
        break;
      case 1:
        Get.to(() => PostAddPage());
        break;
      case 2:
        Get.to(() => const Chatting()); //채팅내역으로 바꿔야함
        break;
      case 3:
        //채팅내역으로 바꿔야함
        Get.to(() => InfoPage());
        break;
      default:
        break;
    }
  }
}

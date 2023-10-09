import 'package:get/instance_manager.dart';
import 'package:mobile/controller/add_product_controller.dart';

import 'package:mobile/controller/bottom_bar_controller.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/controller/date_picker_controller.dart';
import 'package:mobile/controller/dropdown_controller.dart';
import 'package:mobile/controller/homeController.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/join_controller.dart';
import 'package:mobile/controller/map_controller.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/controller/search_textfield_controller.dart';
import 'package:mobile/controller/sell_product_controller.dart';
import 'package:mobile/controller/sse_controller.dart';
import 'package:mobile/controller/sse_price_controller.dart';
import 'package:mobile/controller/tabbar_controller.dart';
import 'package:mobile/model/product_search_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final infinitescrollController = InfiniteScrollController(
        searchData: ProductSearchModel(
            keyword: "",
            category: "",
            nick_name: "",
            closed: "ALL",
            search_time: true,
            like: true,
            search_price: true,
            basic: true),
        mode: "all");
    final commentScrollController = CommentScrollController(productId: 3);

    final homeController = HomeController();
    final tabbarController = TabbarController();
    final sellProductController = SellProductController();
    final searchTextfieldController = SearchTextfieldController();
    final dropdownController = DropdownController();
    final bottomBarController = BottomBarController();
    final datePickerController = DatePickerController();

    final addProductController = AddProductController();
    final ssePriceController = SsePriceController();
    final JoinController joinController = Get.put(JoinController()); // 컨트롤러 초기화
    final MapController mapController = Get.put(MapController());
    final ProfileController profileController = ProfileController();
    final SseController sseController = SseController();

    Get.put(sseController);
    Get.put(profileController);
    Get.put(ssePriceController);
    Get.put(commentScrollController);

    Get.put(addProductController);
    Get.put(datePickerController);
    Get.put(infinitescrollController);
    Get.put(homeController);
    Get.put(tabbarController);
    Get.put(sellProductController);
    Get.put(searchTextfieldController);
    Get.put(dropdownController);
    Get.put(bottomBarController);
  }
}

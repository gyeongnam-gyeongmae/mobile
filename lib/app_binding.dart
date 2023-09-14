import 'package:get/instance_manager.dart';
import 'package:mobile/controller/homeController.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/sell_product_controller.dart';
import 'package:mobile/controller/tabbar_controller.dart';

class AppBinding extends Bindings{

  @override
  void dependencies(){
    final infiniteScrollController = InfiniteScrollController();
    final homeController = HomeController();
    final tabbarController = TabbarController();
    final sellProductController = SellProductController();

    Get.put(infiniteScrollController);
    Get.put(homeController);
    Get.put(tabbarController);
    Get.put(sellProductController);
  }
}

import 'package:get/instance_manager.dart';
import 'package:mobile/controller/homeController.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/tabbar_controller.dart';

class AppBinding extends Bindings{

  @override
  void dependencies(){
    final infiniteScrollController = InfiniteScrollController();
    final homeController = HomeController();
    final tabbarController = TabbarController();

    Get.put(infiniteScrollController);
    Get.put(homeController);
    Get.put(tabbarController);
  }
}

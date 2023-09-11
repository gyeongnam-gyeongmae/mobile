import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile/controller/homeController.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final infiniteScrollController = InfiniteScrollController();
    final homeController = HomeController();

    Get.put(infiniteScrollController);
    Get.put(homeController);
  }
}

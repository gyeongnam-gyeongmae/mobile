import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/bottom_bar_controller.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';

//아래 네비게이션 바
class MainBottomBar extends GetView<BottomBarController> {
  const MainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int selectedIndex = controller.selectedIndex.value;
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded), label: '경매'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded), label: '내 정보')
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          controller.changePage(index);
        },
      );
    });
  }
}

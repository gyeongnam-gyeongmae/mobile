import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/views/pages/map.dart';
import 'package:mobile/views/pages/my_info_page.dart';
import 'package:mobile/views/pages/search_page.dart';
import 'package:mobile/views/widget/dropdown/location_dropdown.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Colors.white,
      leadingWidth: 300,
      leading: const LocationDropdown(),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(const SearchPage());
            },
            icon: const Icon(Icons.search, color: Colors.grey),
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0)),
        const IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications),
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
        IconButton(
            onPressed: () => onButtonPressed(context), // context를 전달하여 이동합니다.
            icon: const Icon(Icons.location_pin),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
  void onButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // 이동할 페이지의 위젯을 반환합니다.
          return const NaverMapTest(); // YourNewPage는 이동하려는 페이지의 위젯입니다.
        },
      ),
    );
  }
}

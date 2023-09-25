import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      actions: const [
        IconButton(
            onPressed: (){
              Get.to(SearchPage());
            },
            icon: Icon(Icons.search, color: Colors.grey),
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
        IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications),
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

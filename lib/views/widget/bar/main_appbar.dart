import 'package:flutter/material.dart';
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
            onPressed: null,
            icon: Icon(Icons.search),
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

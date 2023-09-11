import 'package:flutter/material.dart';
import 'package:mobile/screens/location_dropdown.dart';


class Homescreen extends StatelessWidget implements PreferredSizeWidget{
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leadingWidth: 300,
        leading: LocationDropdown(),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.search),padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
          IconButton(onPressed: null, icon: Icon(Icons.notifications),padding: EdgeInsets.fromLTRB(0, 8, 0, 0))
        ],
      );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(70);
}
import 'package:flutter/material.dart';

//아래 네비게이션 바
class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.edit_document), label: '현황'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded), label: '내 정보')
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
    );
  }
}

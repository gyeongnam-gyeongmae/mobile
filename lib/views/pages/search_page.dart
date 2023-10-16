import 'package:flutter/material.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/bar/search_appbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 수직 방향 정렬을 왼쪽으로 설정
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}

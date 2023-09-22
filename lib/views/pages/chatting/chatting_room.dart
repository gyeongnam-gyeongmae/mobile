import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:mobile/views/widget/info_tabbar.dart';
import 'package:mobile/views/widget/main_appbar.dart';
import 'package:mobile/views/widget/main_bottom_bar.dart';

class ChattingRom extends StatelessWidget {
  const ChattingRom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 250, 250, 250),
          title: const Row(
            children: [
              Icon(
                Icons.keyboard_arrow_left,
                size: 45,
                color: Colors.grey,
              ),
              Text(
                "        상대 이름",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

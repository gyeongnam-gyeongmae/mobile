import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:mobile/views/widget/info_tabbar.dart';
import 'package:mobile/views/widget/main_appbar.dart';
import 'package:mobile/views/widget/main_bottom_bar.dart';

class Chatting extends StatelessWidget {
  const Chatting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 250, 250, 250),
          title: const Row(
            children: [
              Text(
                "    채팅",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 270,
              ),
              Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 30,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0, // 그림자 없애기
                  backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                ),
                onPressed: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 116, 116, 116), // 테두리 색상 설정
                        width: 1.0, // 테두리 두께 설정
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/kakao.png"),
                          width: 40.0,
                        ),
                        Column(
                          children: [
                            Text(
                              "15:00",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "          이것 저것 메세지",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const MainBottomBar(),
      ),
    );
  }
}

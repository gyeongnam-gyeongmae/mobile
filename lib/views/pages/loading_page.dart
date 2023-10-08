import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart'; // Get 패키지의 모든 기능을 사용하기 위해 Get 패키지를 import 합니다.

import 'package:mobile/app_binding.dart';
import 'package:mobile/views/pages/main_page.dart';
import 'package:mobile/views/pages/post_add_page.dart';
import 'package:mobile/views/pages/chatting/chatting.dart';
import 'package:mobile/views/pages/join/join_page.dart';
import 'package:mobile/views/pages/join/login_page.dart';
import 'package:mobile/views/pages/main_page.dart';
import 'package:mobile/views/pages/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

// LoginPage 클래스가 있는 파일을 import 합니다.

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // 화면이 빌드된 후 3초 후에 LoginPage로 이동
    Future.delayed(const Duration(seconds: 1), () async {
      final cookies = "SESSION=NWQwMzBjYTYtOWExYy00N2EzLWFmMzYtOTY5MTk5MzQyNzBi; Path=/; HttpOnly;";
      final prefs = await SharedPreferences.getInstance();
      final cookie2 = prefs.setString("JSESSIONID", cookies);
      final cookie = prefs.getString("JSESSIONID");
       if (cookie != null) {
        Get.to(() => MainPage());
      } else {
      Get.to(() => LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      // GetMaterialApp을 사용
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Best Deal",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

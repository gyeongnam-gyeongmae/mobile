import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart'; // Get 패키지의 모든 기능을 사용하기 위해 Get 패키지를 import 합니다.

import 'package:mobile/app_binding.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/controller/profile_image_controller.dart';
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
    Get.put(ProfileController());
    // 화면이 빌드된 후 3초 후에 LoginPage로 이동
    Future.delayed(const Duration(seconds: 1), () async {
      final prefs = await SharedPreferences.getInstance();

      // final cookie = prefs.getString("JSESSIONID");
      final cookie = prefs.setString("JSESSIONID", "SESSION=NTNlZmNlZWYtMWFmMC00ZWZmLWI0OGUtYjE1ZmE2ZDUyYzJm; Path=/; HttpOnly;");

      ProfileController.to.setId(2);
      ProfileController.to.setNickname("임채성");
      ProfileController.to.setImageUrl("https://yt3.ggpht.com/a/default-user=s88-c-k-c0x00ffffff-no-rj");
      ProfileImageController profileImageController = ProfileImageController();
      profileImageController.getUserProfile();
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

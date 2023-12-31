import 'package:flutter/material.dart';

import 'package:get/get.dart'; // Get 패키지의 모든 기능을 사용하기 위해 Get 패키지를 import 합니다.

import 'package:mobile/app_binding.dart';
import 'package:mobile/views/pages/main_page.dart';

import 'package:mobile/views/pages/join/join_page.dart';
import 'package:mobile/views/pages/join/login_page.dart';

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
      final prefs = await SharedPreferences.getInstance();

      Get.to(() => LoginPage());
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

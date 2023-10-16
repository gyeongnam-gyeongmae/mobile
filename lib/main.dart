import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/views/pages/join/login_page.dart';
import 'package:mobile/views/pages/loading_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: '6ssx6jig5p');
  final ProfileController profileController = Get.put(ProfileController());
  runApp(const LoadingPage());
}

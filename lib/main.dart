import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mobile/views/pages/join/login_page.dart';
import 'package:mobile/views/pages/loading_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: '6ssx6jig5p');

  runApp(const LoadingPage());
}

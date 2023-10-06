import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:mobile/models/map_model.dart';
import 'package:mobile/services/map_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapController extends GetxController {
  RxString city = ''.obs;
  final MapService mapService = MapService();

  // API 요청을 보내는 메서드
  Future<MapModel?> postLocation(Position position) async {
    final prefs = await SharedPreferences.getInstance();
    var cookie = prefs.getString("JSESSIONID");

    try {
      return await mapService.postLocation(position, cookie!);
    } catch (e) {
      // 예외 처리
      print('Error: $e');
    }
    return null;
  }
}

import 'package:get/get.dart';
import 'package:mobile/models/chatting_message.dart';
import 'package:mobile/models/chatting_message_detail.dart';

import 'package:mobile/services/chatting_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chattingcontroller extends GetxController {
  final ChattingService chattingService = ChattingService();

  late Rx<DateTime> updateAt;
  RxInt id = 0.obs;
  RxString name = ''.obs;

  // API 요청을 보내는 메서드
  Future<Map<int, List<ChattingMessage>>?> getChatRooms() async {
    final prefs = await SharedPreferences.getInstance();
    var cookie = prefs.getString("JSESSIONID");

    try {
      return await chattingService.getChatRooms(cookie!);
    } catch (e) {
      // 예외 처리
      print('Error: $e');
    }
    return null;
  }

  Future<List<ChattingMessageDetail>?> getMessages(int roomId) async {
    final prefs = await SharedPreferences.getInstance();
    var cookie = prefs.getString("JSESSIONID");
    try {
      return await chattingService.getMessages(cookie!, roomId.toString());
    } catch (e) {
      print("error: $e");
    }
    return null;
  }
}

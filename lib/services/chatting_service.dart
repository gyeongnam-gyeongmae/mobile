import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/chatting_message.dart';
import 'package:mobile/models/chatting_message_detail.dart';
import 'package:mobile/models/chatting_room.dart';
import 'package:mobile/views/pages/join/phone_page.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChattingService {
  final http.Client httpClient = http.Client();

  final String baseUrl = 'http://203.241.228.51:5000';
  final CookieJar cookieJar = CookieJar(); // CookieJar 인스턴스 생성

  Future<Map<int, List<ChattingMessage>>> getChatRooms(String cookie) async {
    final sessionValue = extractSessionFromCookie(cookie);
    if (sessionValue == null) {
      throw Exception('세션 쿠키에서 SESSION 값을 찾을 수 없습니다.');
    }
    print(sessionValue);
    print(cookie);

    final uri = Uri.parse(baseUrl);
    final sessionCookie = Cookie('SESSION', sessionValue);
    await cookieJar.saveFromResponse(uri, [sessionCookie]);

    // 저장한 쿠키를 요청 헤더에 추가하여 HTTP 요청 보내기
    final url = Uri.parse('$baseUrl/chat-rooms');
    final cookies = await cookieJar.loadForRequest(url);
    final cookieHeader =
        cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
    final response = await httpClient.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode == 200) {
      // 서버 응답을 반환
      final List<ChattingRoom> rooms = List<ChattingRoom>.from(
        json.decode(response.body).map((data) {
          return ChattingRoom.fromJson(data);
        }),
      );

      Map<int, List<ChattingMessage>> roomMessagesMap = {};
      for (var room in rooms) {
        final uri = Uri.parse('$baseUrl/chat-rooms/${room.id}/messages');

        final response = await httpClient.get(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Cookie': cookieHeader,
          },
        );
        print(1);
        if (response.statusCode == 200) {
          final List<ChattingMessage> messages = List<ChattingMessage>.from(
            jsonDecode(utf8.decode(response.bodyBytes)).map((data) {
              return ChattingMessage.fromJson(data);
            }),
          );
          print(1);

          roomMessagesMap[room.id] = messages;
        } else {
          throw Exception('데이터를 불러오는 데 실패했습니다.');
        }
      }

      return roomMessagesMap;
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('데이터를 불러오는 데 실패했습니다.');
    }
  }

  String? extractSessionFromCookie(String cookieString) {
    final sessionMatch = RegExp(r'SESSION=([^;]+)').firstMatch(cookieString);
    if (sessionMatch != null) {
      return sessionMatch.group(1);
    }
    return null;
  }

  Future<List<ChattingMessageDetail>> getMessages(
      String cookie, String roomId) async {
    final sessionValue = extractSessionFromCookie(cookie);
    if (sessionValue == null) {
      throw Exception('세션 쿠키에서 SESSION 값을 찾을 수 없습니다.');
    }
    final uri = Uri.parse(baseUrl);
    final url = Uri.parse('$baseUrl/chat-rooms/$roomId/messages');
    final sessionCookie = Cookie('SESSION', sessionValue);
    await cookieJar.saveFromResponse(uri, [sessionCookie]);
    final cookies = await cookieJar.loadForRequest(url);
    final cookieHeader =
        cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
    final response = await httpClient.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode == 200) {
      final List<ChattingMessageDetail> messages =
          List<ChattingMessageDetail>.from(
        jsonDecode(utf8.decode(response.bodyBytes)).map((data) {
          return ChattingMessageDetail.fromJson(data);
        }),
      );
      return messages;
    } else {
      throw Exception('데이터를 불러오는 데 실패했습니다.');
    }
  }

  Future<void> sendMessages(String message, String roomId) async {
    StompClient client = StompClient(
        config: StompConfig(
            url:
                'ws://203.241.228.51:5000/connect/subscribe/chat-rooms/$roomId',
            onConnect: onConnectCallback));
    client.activate();
  }

  void onConnectCallback(StompFrame p1) {}
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/chatting_controller.dart';
import 'package:mobile/models/chatting_message.dart';
import 'package:mobile/models/chatting_room.dart';
import 'package:mobile/views/pages/chatting/chatting_room.dart';
import 'package:mobile/views/widget/%08chattingWidget.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';

class Chatting extends StatefulWidget {
  const Chatting({Key? key}) : super(key: key);

  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final Chattingcontroller chattingController = Get.put(Chattingcontroller());
  late Future<Map<int, List<ChattingMessage>>?> message;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    message = chattingController.getChatRooms();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 동적으로 ChattingWidget 위젯을 생성하는 함수
  List<Widget> buildChatContainers(Map<int, List<ChattingMessage>>? message) {
    List<Widget> containers = [];

    if (message != null) {
      message.forEach((roomId, roomMessages) {
        ChattingMessage message = roomMessages[roomMessages.length - 1];
        String time = message.updatedAt;
        String messageText = message.content;

        DateTime datetime = DateTime.parse(time);
        String formattedDateTime = DateFormat('HH:mm').format(datetime);

        containers.add(
          ChattingWidget(
            onPressed: () {
              Get.to(() => ChattingRom(
                    roomId,
                    message.user,
                  ));
            },
            time: formattedDateTime,
            message: messageText,
            id: message.id,
            user: message.user,
          ),
        );
      });
    }

    return containers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        title: const Row(
          children: [
            Text(
              "채팅",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 240,
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
        child: FutureBuilder<Map<int, List<ChattingMessage>>?>(
          future: message,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No data available.');
            } else {
              final chatRooms = snapshot.data!;
              return ListView(
                controller: _scrollController, // 스크롤 컨트롤러 설정
                children: buildChatContainers(chatRooms),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}

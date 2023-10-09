import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:intl/intl.dart';
import 'package:mobile/controller/chatting_controller.dart';

import 'package:mobile/models/chatting_message_detail.dart';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChattingRom extends StatefulWidget {
  final int roomId;
  final String user;
  const ChattingRom(this.roomId, this.user, {Key? key}) : super(key: key);

  @override
  _ChattingRomState createState() => _ChattingRomState(roomId, user);
}

class _ChattingRomState extends State<ChattingRom> {
  final controller = Get.find<Chattingcontroller>();
  late final StompClient stompClient;
  late List<ChattingMessageDetail>? messages = []; // 빈 리스트로 초기화
  late ScrollController _scrollController;
  final TextEditingController _textEditingController = TextEditingController();
  final bool _isInitialized = false;
  final int roomId;
  final String user;
  _ChattingRomState(this.roomId, this.user); // 초기화 여부를 추적하는 변
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    initMessages(); // 처음 시작할 때만 초기화 함수 호출

    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://203.241.228.51:5000/connect',
        onConnect: (StompFrame frame) {
          stompClient.subscribe(
              destination: '/subscribe/chat-rooms/$roomId',
              headers: {},
              callback: onCallBack);
        },
      ),
    );
    stompClient.activate();
  }

  void onCallBack(StompFrame frame) {
    // 구독 콜백
    final body = frame.body!;
    print(body);
    final message = ChattingMessageDetail.fromJson2(json.decode(body));
    print(message);
    setState(() {
      messages!.add(message);
    });

    for (int i = 0; i < messages!.length; i++) {
      print(messages?[i]);
    }
    print("LEGNTH");
    print(messages?.length);
  }

  // 초기 메시지를 가져오기 위한 함수
  void initMessages() async {
    final initialMessages = await controller.getMessages(widget.roomId);
    print(widget.roomId);

    setState(() {
      messages = initialMessages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/person.jpg"),

                    backgroundColor:
                        Color.fromARGB(255, 159, 197, 240), // 배경색 설정

                    maxRadius: 20,
                    child: Icon(
                      Icons.person, // 사용할 아이콘 선택
                      size: 30, // 아이콘 크기 설정
                      color: Color.fromARGB(255, 8, 8, 8), // 아이콘 색상 설정
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          user,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  /*
                  */
                  const Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Stack(
            children: <Widget>[
              ListView.builder(
                controller: _scrollController,
                itemCount: messages!.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: messages![index].userId == 1
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: messages![index].userId == 1
                                ? Colors.grey.shade200
                                : Colors.blue[200],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages![index].content,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(width: 8), // 메시지와 시간 사이 간격 조정
                        Text(
                          DateFormat('HH:mm').format(DateTime.parse(
                              messages![index].createdAt)), // 시간 표시
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {
                    final messageText = _textEditingController.text;
                    if (messageText.isNotEmpty) {
                      stompClient.send(
                        destination: '/publish/chat-rooms/$roomId',
                        body: json.encode({
                          "userId": 1,
                          "content": messageText,
                          "messageType": "TALK"
                        }),
                        headers: {},
                      );
                      _textEditingController.clear();
                    }
                  },
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }
}

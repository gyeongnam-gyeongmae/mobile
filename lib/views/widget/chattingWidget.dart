import 'package:flutter/material.dart';

class ChattingWidget extends StatelessWidget {
  final String time;
  final String message;
  final VoidCallback onPressed;
  final int id;
  final String user;
  const ChattingWidget({
    Key? key,
    required this.time,
    required this.message,
    required this.onPressed, // onPressed를 필수로 받도록 수정
    required this.id,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
      ),
      child: Container(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0, // 그림자 없애기
            backgroundColor: const Color.fromARGB(255, 250, 250, 250),
          ),
          onPressed: onPressed, // 전달받은 onPressed 함수를 사용
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 250, 250, 250), // 테두리 색상 설정
                  width: 1.0, // 테두리 두께 설정
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/kakao.png"),
                    maxRadius: 25,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              user,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              message,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

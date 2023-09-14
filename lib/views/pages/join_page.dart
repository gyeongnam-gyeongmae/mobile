import 'package:flutter/material.dart';
import 'package:mobile/views/widget/button/join_page_button.dart';
import 'package:mobile/views/widget/textfield/join_page_textfield.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 250, 250, 250),
            leading: const Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left,
                  size: 54,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "    나의 첫 경매\n    시작해볼까요?",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  '     휴대폰 번호가 바뀌었을때 필요해요!\n\n', // 원하는 제목 텍스트
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 99, 99, 99),
                  ),
                ),
                TextFieldWidget(
                  hintText: "이메일 입력하세요!",
                  width: 400,
                  height: 40,
                  padding: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const JoinPageButton(
                  height: 40,
                  width: 400,
                  padding: 20,
                  text: "계속하기",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

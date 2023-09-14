import 'package:flutter/material.dart';
import 'package:mobile/views/widget/button/join_page_button.dart';
import 'package:mobile/views/widget/textfield/join_page_textfield.dart';
class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

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
            title: const Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left,
                  size: 45,
                  color: Colors.grey,
                ),
                Text(
                  "                회원가입",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "     휴대폰 번호 입력",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                TextFieldWidget(
                  hintText: "휴대폰 번호를 입력해 주세요",
                  width: 400,
                  height: 40,
                  padding: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                const JoinPageButton(
                  height: 40,
                  width: 400,
                  padding: 20,
                  text: "인증번호 받기",
                ),
                const Text(
                  " \n\n    인증번호 입력",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                TextFieldWidget(
                  hintText: "인증번호를 입력해 주세요",
                  width: 400,
                  height: 40,
                  padding: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                const JoinPageButton(
                  height: 40,
                  width: 400,
                  padding: 20,
                  text: "인증번호 받기",
                ),
                const SizedBox(
                  height: 50,
                ),
                const JoinPageButton(
                  height: 100,
                  width: 320,
                  padding: 120,
                  text: "최고의 경매 시작하기!",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

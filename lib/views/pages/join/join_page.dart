import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile/controller/join_controller.dart';
import 'package:mobile/views/pages/join/phone_page.dart';
import 'package:mobile/views/pages/main_page.dart';
import 'package:mobile/views/widget/join_page_button.dart';

import 'package:mobile/views/widget/textfield/join_page_textfield.dart';

class JoinPage extends GetView<JoinController> {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? phoneNumber; // TextFieldWidget의 값을 저장할 변수
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
                  hintText: "휴대폰 번호를 입력하세요!!",
                  width: 400,
                  height: 70,
                  padding: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                JoinPageButton(
                  height: 40,
                  width: 400,
                  padding: 20,
                  text: "계속하기",
                  onTap: () {
                    if (controller.checkPhoneNumber == true) {
                      print(controller.checkPhoneNumber);
                      controller.sendPhoneVerificationRequest();
                      Get.to(() => MainPage());
                    } else {
                      print(controller.checkPhoneNumber);
                      print("에러");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/join_controller.dart';
import 'package:mobile/views/widget/button/join_page_button.dart';
import 'package:mobile/views/widget/phone_text.dart';

class PhonePage extends GetView<JoinController> {
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
                const Text(
                  "      \n   마지막 단계예요!",
                  style: TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  " \n    인증번호 입력",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                PhoneText(
                  hintText: "인증번호를 입력해 주세요",
                  width: 400,
                  height: 40,
                  padding: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                JoinPageButton(
                  height: 40,
                  width: 400,
                  padding: 20,
                  text: "인증번호 확인",
                  onTap: () {
                    if (controller.getPhoneVerificationRequest() == false) {
                      // 인증번호가 틀렸을 때 다이얼로그 출력
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("인증번호 오류"),
                            content: const Text("인증번호가 틀렸습니다."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("확인"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // 다이얼로그 닫기
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // 인증번호가 맞을 때 다이얼로그 출력
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("인증번호 확인"),
                            content: const Text("인증번호가 맞습니다."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("확인"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // 다이얼로그 닫기
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                JoinPageButton(
                  height: 100,
                  width: 320,
                  padding: 100,
                  text: "Best Deal 시작하기!",
                  onTap: () {
                    controller.register();
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:mobile/controller/join_controller.dart';
import 'package:mobile/views/pages/join/join_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final JoinController joinController = Get.put(JoinController()); // 컨트롤러 초기화

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: Container(
            color: Colors.white,

            child: Column(
              children: [
                const SizedBox(height: 100), // 16 픽셀의 공백 추가
                const Text(
                  "Best Deal",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "경매 기반 이커머스 플랫폼, \n" "              베스트 딜!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "              쉽고 재밌는 경매\n지금 베스트 딜에서 시작하세요.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),

                GestureDetector(
                  onTap: () async {
                    KakaoSdk.init(
                        nativeAppKey: '645b92f45343c7fecbd50ac2090d360e');
                    try {
                      bool isInstalled = await isKakaoTalkInstalled();

                      OAuthToken token = isInstalled
                          ? await UserApi.instance.loginWithKakaoTalk()
                          : await UserApi.instance.loginWithKakaoAccount();
                      print(token.accessToken);
                      joinController.setVendorAccessToken(token.accessToken);
                      Get.to(() => const JoinPage());
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                    }
                  },
                  child: Container(
                    width: 290,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 226, 0, 1.0),
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.transparent, // 클릭 효과 비활성화
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/kakao.png"),
                          width: 100.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "카카오로 로그인",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ), // 원하는 배경색으로 변경하세요.
          ),
        ),
      ),
    );
  }
}

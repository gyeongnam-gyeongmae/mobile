import 'package:flutter/material.dart';
import 'package:mobile/views/pages/kakao_oauth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
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

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KakaoOauth()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor:
                          const Color.fromRGBO(255, 226, 0, 1.0), // 버튼의 텍스트 색상
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(7), // 버튼의 모서리를 라운드 처리
                      ),
                      fixedSize: const Size(290, 50)),
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
                  ), // 버튼에 표시할 텍스트
                ),
              ],
            ), // 원하는 배경색으로 변경하세요.
          ),
        ),
      ),
    );
  }
}

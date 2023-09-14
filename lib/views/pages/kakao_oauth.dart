import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';

class KakaoOauth extends StatelessWidget {
  const KakaoOauth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    KakaoSdk.init(nativeAppKey: '645b92f45343c7fecbd50ac2090d360e');
    return MaterialApp(
        home: Container(
            color: Colors.white,
            child: Center(
                child: ElevatedButton(
                    child: const Text("카카오 로그인"),
                    onPressed: () async {
                      if (await isKakaoTalkInstalled()) {
                        try {
                          await UserApi.instance.loginWithKakaoTalk();
                          print('카카오톡으로 로그인 성공');
                        } catch (error) {
                          print('카카오톡으로 로그인 실패 $error');

                          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                          if (error is PlatformException &&
                              error.code == 'CANCELED') {
                            return;
                          }
                          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                          try {
                            await UserApi.instance.loginWithKakaoAccount();
                            print('카카오계정으로 로그인 성공');
                          } catch (error) {
                            print('카카오계정으로 로그인 실패 $error');
                          }
                        }
                      } else {
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          print('카카오계정으로 로그인 성공');
                        } catch (error) {
                          print('카카오계정으로 로그인 실패 $error');
                        }
                      }
                    }))));
  }
}

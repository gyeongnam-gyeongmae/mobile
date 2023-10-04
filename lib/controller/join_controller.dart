import 'package:get/get.dart';
import 'package:mobile/services/join_service.dart';

class JoinController extends GetxController {
  final JoinService joinService = JoinService();

  RxString vendorAccessToken = ''.obs;
  RxString phoneNumbers = ''.obs;
  RxBool checkPhoneNumber = false.obs;
  RxString authenticationNumber = ''.obs;

  void setVendorAccessToken(String token) {
    vendorAccessToken.value = token;
  }

  void setPhoneNumber(String phoneNumber) {
    phoneNumbers.value = phoneNumber;
  }

  void setCheckPhoneNumber(bool check) {
    checkPhoneNumber = check as RxBool;
  }

  void setAuthenticationNumber(String number) {
    authenticationNumber.value = number;
  }

  // API 요청을 보내는 메서드
  void sendPhoneVerificationRequest() async {
    try {
      await joinService.sendPhoneVerificationRequest(phoneNumbers.value);
    } catch (e) {
      // 예외 처리
      print('Error: $e');
    }
  }

  void getPhoneVerificationRequest() async {
    try {
      await joinService.getPhoneVerificationRequest(
          phoneNumbers.value, authenticationNumber.value);
    } catch (e) {
      // 예외 처리
      print('Error: $e');
    }
  }

  void register() async {
    try {
      await joinService.register(
        phoneNumbers.value,
        authenticationNumber.value,
        vendorAccessToken.value,
      );
    } catch (e) {
      // 예외 처리
      print('Error: $e');
    }
  }

/*
  Future<void> registerUser({
    required String vendorAccessToken,
    required String phoneNumber,
    required String phoneAuthenticationCode,
    required String password,
  }) async {
    try {
      final user = await joinService.registerUser(
        vendorAccessToken: vendorAccessToken,
        phoneNumber: phoneNumber,
        phoneAuthenticationCode: phoneAuthenticationCode,
        password: password,
      );

      // 성공적으로 회원 가입한 사용자 정보를 출력
      print('회원 가입 성공 - 사용자 정보: ${user.username}, ${user.email}');
    } catch (e) {
      // 오류 처리
      print('회원 가입 오류 - $e');
    }
  }
*/
}

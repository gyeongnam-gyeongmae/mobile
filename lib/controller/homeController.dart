import 'package:get/get.dart';

class HomeController extends GetxController {
  var value = 0.obs;

  void updateValue(int newValue) {
    value.value = newValue;
  }

  // value 값을 가져오는 메서드
  int get getValue => value.value;
}

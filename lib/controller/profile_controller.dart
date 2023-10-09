import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProfileController extends GetxController {
  int? id;
  String? nickName;

  static ProfileController get to => Get.find();
}

class ProfileClass extends GetxController {
  String? getNickName() {
    final globalNickName = ProfileController.to.nickName;
    return globalNickName;
  }

  int? getId() {
    final globalId = ProfileController.to.id;
    return globalId;
  }
}

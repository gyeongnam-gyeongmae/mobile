import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProfileController extends GetxController {
  int id = 0;
  String nickName = "";
  void setId(int userId){
    id = userId;
  }

  void setNickname(String nickname){
    nickName = nickname;
  }

  int getId(){
    return id;
  }

  String getNickname(){
    return nickName;
  }

  static ProfileController get to => Get.find();
}


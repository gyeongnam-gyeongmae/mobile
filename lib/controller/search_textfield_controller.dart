import 'package:get/get.dart';

class SearchTextfieldController extends GetxController{
  RxString content = '샘성 캐매라'.obs;

  void setContent(String content){
    this.content.value = content;
  }
}
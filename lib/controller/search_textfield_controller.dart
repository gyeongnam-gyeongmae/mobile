import 'package:get/get.dart';

class SearchTextfieldController extends GetxController{
  RxString content = ''.obs;

  void setContent(String content){
    this.content.value = content;
  }
}
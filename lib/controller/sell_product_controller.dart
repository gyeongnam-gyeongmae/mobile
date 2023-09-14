import 'package:get/get.dart';

class SellProductController extends GetxController{
  RxInt selectedId = 0.obs;

  void setSelectedId(int id){
    selectedId.value = id;
  }
}
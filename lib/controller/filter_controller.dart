import 'dart:ffi';

import 'package:get/get.dart';

class FilterController extends GetxController{
  RxBool searchPopular = true.obs;
  RxBool searchPrice = true.obs;
  RxBool searchClose = true.obs;

  void setPopular(bool result){
    searchPopular.value = result;
  }

  void setPrice(bool result){
    searchPrice.value = result;
  }

  void setClose(bool result){
    searchClose.value = result;
  }
}
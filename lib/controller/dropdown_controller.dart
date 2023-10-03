import 'package:get/get.dart';

class DropdownController extends GetxController {
  RxString popularItem = '인기 많은순'.obs;
  RxBool popularBool = true.obs;

  RxString priceItem = '가격 높은순'.obs;
  RxBool priceBool = true.obs;

  RxString sellItem = '판매중'.obs;
  RxBool sellBool = true.obs;

  RxString categoryItem = '기타'.obs;

  void setPopularItem(String item) {
    popularItem.value = item;
  }

  void setPopularBool(bool result){
    popularBool.value = result;
  }

  void setPriceItem(String item){
    priceItem.value = item;
  }

  void setPriceBool(bool result){
    priceBool.value = result;
  }

  void setSellItem(String item){
    sellItem.value = item;
  }

  void setSellBool(bool result){
    sellBool.value = result;
  }

  void setCategoryItem(String item) {
    categoryItem.value = item;
  }
}

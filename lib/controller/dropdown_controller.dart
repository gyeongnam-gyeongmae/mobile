import 'package:get/get.dart';

class DropdownController extends GetxController {
  RxString popularItem = '인기 많은순'.obs;
  RxString priceItem = '가격 높은순'.obs;
  RxString sellBool = '판매중'.obs;
  RxString categoryItem = '기타'.obs;

  void setPopularItem(String item) {
    popularItem.value = item;
  }

  void setPriceItem(String item) {
    priceItem.value = item;
  }

  void setSellBool(String item) {
    sellBool.value = item;
  }

  void setCategoryItem(String item) {
    categoryItem.value = item;
  }
}

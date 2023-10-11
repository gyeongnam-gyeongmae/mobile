import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SsePriceController extends GetxController {
  RxInt price = 0.obs;
  void setPrice(int price) {
    this.price.value = price;
  }

  void updatePrice(int price) {
    this.price.value += price;
  }
}

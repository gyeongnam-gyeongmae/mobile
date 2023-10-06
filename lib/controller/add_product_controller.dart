import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/add_product_model.dart';
import 'package:mobile/service/add_product_service.dart';

class AddProductController extends GetxController {
  final AddProductModel addProductModel = AddProductModel(
      title: "",
      price: 0,
      category: "기타",
      content: "",
      closeTime: DateTime.now(),
      userId: 1);

  RxList<XFile?> images = RxList<XFile?>([]);

  final AddProductService addProductService = AddProductService();

  Future<int> AddProduct() {
    return addProductService.addProduct(addProductModel, images);
  }

  void reset() {
    setTitle("");
    setPrice(0);
    setCategory("기타");
    setContent("");
    images.clear();
  }

  void setTitle(String title) {
    addProductModel.title = title;
    update();
  }

  void setPrice(int price) {
    addProductModel.price = price;
    update();
  }

  void setCategory(String category) {
    addProductModel.category = category;
    update();
  }

  void setContent(String content) {
    addProductModel.content = content;
    update();
  }

  void setCloseTime(DateTime time) {
    addProductModel.closeTime = time;
    update();
  }

  void setUserId(int id) {
    addProductModel.userId = id;
    update();
  }
}

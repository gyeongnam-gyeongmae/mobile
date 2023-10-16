import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/bottom_bar_controller.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/views/pages/search_page.dart';
import 'package:mobile/views/widget/dropdown/location_dropdown.dart';

class ProductDetailAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final int productId;
  ProductDetailAppbar({required this.productId, super.key});
  final InfiniteScrollController controller =
      Get.find<InfiniteScrollController>();
  final BottomBarController barController = Get.find<BottomBarController>();
  final int userId = 1;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Colors.white,
      leadingWidth: 300,
      leading: const LocationDropdown(),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(const SearchPage());
            },
            icon: const Icon(Icons.search, color: Colors.grey),
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0)),
        if (userId == 1)
          IconButton(
              onPressed: () {
                //1대신에 쿠키의 유저 아이디 비교하기
                _productRemove(context).then((value) async {
                  if (value == 'remove') {
                    controller.removeProduct(productId);
                    barController.changePage(0);
                    barController.update();
                  }
                });
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 30,
              ),
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0))
      ],
    );
  }

  Future<dynamic> _productRemove(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: const Text("경매를 중단하시겠습니까?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'remove');
                  },
                  child:
                      const Text('삭제하기', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'cancel');
                    },
                    child:
                        const Text('취소', style: TextStyle(color: Colors.black)))
              ],
            ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

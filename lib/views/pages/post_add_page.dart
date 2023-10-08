import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/add_product_controller.dart';
import 'package:mobile/controller/bottom_bar_controller.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/controller/date_picker_controller.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/views/pages/product_detail_page.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/dropdown/category_dropdown.dart';
import 'package:mobile/views/widget/picker/custom_datepicker.dart';
import 'package:mobile/views/widget/picker/custom_timepicker.dart';
import 'package:mobile/views/widget/picker/image_picker_container.dart';

class PostAddPage extends GetView<AddProductController> {
  PostAddPage({super.key});

  final DatePickerController datePickerController =
      Get.find<DatePickerController>();
  final BottomBarController barController = Get.find<BottomBarController>();
  final InfiniteScrollController scrollController =
      Get.find<InfiniteScrollController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '제목',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width) - 30,
                        child: TextField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15)
                          ],
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 7),
                            hintText: '판매 물품 이름을 포함해 주세요.',
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blueAccent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            controller.setTitle(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '물건 설명',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width) - 30,
                        child: TextField(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 7),
                            hintText: '판매 물품 설명',
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blueAccent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          maxLines: 5,
                          onChanged: (value) {
                            controller.setContent(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '종료 시간',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [CustomDatepicker(), CustomTimepicker()],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 13),
                            width: (MediaQuery.of(context).size.width) / 3.5,
                            child: CategoryDropdown(
                                categories: const ['의류', '디지털', '가구', '기타']),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            width: (MediaQuery.of(context).size.width) / 1.8,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                suffixText: '원',
                                border: InputBorder.none,
                                hintText: '경매 시작가를 입력해 주세요.',
                                hintStyle: TextStyle(fontSize: 15),
                              ),
                              onChanged: (value) {
                                controller.setPrice(int.parse(value));
                              },
                            ),
                          ),
                        ],
                      ),
                      ImagePickerContainer(),
                    ],
                  ),
                )),
              ),
              Container(
                width: 400,
                padding: const EdgeInsets.only(bottom: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0), // 라운드 모서리 반경 설정
                    ),
                    backgroundColor: const Color.fromARGB(255, 156, 119, 248),
                  ),
                  onPressed: () async {
                    controller.setCloseTime(datePickerController.getDate());
                    final int id = await controller.AddProduct();
                    barController.selectedIndex(0);
                    final ProductDetailModel product =
                        await scrollController.getProductDetail(id);
                    Get.delete<CommentScrollController>();
                    CommentScrollController commentScrollcontroller =
                        Get.put(CommentScrollController(productId: product.id));
                    await commentScrollcontroller.loadData();
                    datePickerController.updateDate(null);
                    datePickerController.updateTime(null);
                    controller.reset();
                    Get.to(() => ProductDetailPage(
                        controller: commentScrollcontroller,
                        productDetail: product));
                  },
                  child: const Text(
                    '판매하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              )
            ],
          )),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}

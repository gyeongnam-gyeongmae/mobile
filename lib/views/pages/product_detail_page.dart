import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/controller/sse_price_controller.dart';
import 'package:mobile/model/product_detail_model.dart';

import 'package:mobile/views/widget/bar/product_detail_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/product_detail_scroll_view.dart';
import 'package:sse_channel/sse_channel.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailModel productDetail;
  final CommentScrollController controller;
  final textEditingController = TextEditingController();
  final SsePriceController priceController = Get.find<SsePriceController>();

  ProductDetailPage(
      {super.key, required this.controller, required this.productDetail});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final SsePriceController priceController = Get.find<SsePriceController>();
  late SseChannel channel;
  StreamSubscription? stream;
  @override
  void initState() {
    super.initState();
    channel = SseChannel.connect(Uri.parse(
        "http://203.241.228.51:5000/api/auctions/${widget.productDetail.id}/bids"));
    stream = channel.stream.listen((event) {
      if (event != 'init') priceController.setPrice(int.parse(event));
      print(event);
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ProductDetailAppbar(
          productId: widget.productDetail.id,
        ),
        body: ProductDetailScrollView(
            controller: widget.controller, productDetail: widget.productDetail),
        bottomNavigationBar: const MainBottomBar(),
        bottomSheet: GetBuilder<CommentScrollController>(builder: (controller) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // 테두리 색상 설정
                width: 1.0, // 테두리 두께 설정
              ),
              borderRadius: BorderRadius.circular(8.0), // 테두리 모서리 둥글기 설정
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.only(right: 13, left: 13),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundImage:
                      AssetImage('assets/images/kakao.png'), // 이미지 파일의 경로
                ),
                const SizedBox(width: 12), // 이미지와 텍스트 입력 칸 사이의 간격 조절
                Expanded(child: Obx(() {
                  widget.textEditingController.text =
                      controller.editCommentText.value;
                  return TextField(
                    controller: widget.textEditingController,
                    focusNode: controller.textFocus,
                    decoration: InputDecoration(
                      hintText: controller.commentHintText.value,
                      border: InputBorder.none,
                    ),
                  );
                })),
                IconButton(
                  // 오른쪽에 아이콘
                  icon: const Icon(Icons.send), // 아이콘 지정
                  onPressed: () async {
                    if (controller.sendMode == 'add') {
                      await controller.writeComment(
                          // content, productid, userid
                          widget.textEditingController.text,
                          widget.productDetail.id,
                          1);
                    } else if (controller.sendMode == 'edit') {
                      await controller
                          .editComment(widget.textEditingController.text);
                    }
                    controller.textFocus.unfocus();
                    controller.editCommentText.value = "";
                    controller.reload();
                    widget.textEditingController.text = '';
                  },
                ),
              ],
            ),
          );
        }));
  }
}

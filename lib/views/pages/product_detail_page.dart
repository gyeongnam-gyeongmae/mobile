import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/model/write_comment_model.dart';
import 'package:mobile/views/widget/view_container/post_detail_view.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/big_comment_container.dart';
import 'package:mobile/views/widget/view_container/comment_container.dart';
import 'package:mobile/views/widget/view_container/product_detail_scroll_view.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductDetailModel productDetail;
  final CommentScrollController controller;
  final textEditingController = TextEditingController();

  ProductDetailPage({required this.controller, required this.productDetail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppbar(),
        body: ProductDetailScrollView(
            controller: controller, productDetail: productDetail),
        bottomNavigationBar: MainBottomBar(),
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
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(right: 13, left: 13),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage:
                      AssetImage('assets/images/kakao.png'), // 이미지 파일의 경로
                ),
                SizedBox(width: 12), // 이미지와 텍스트 입력 칸 사이의 간격 조절
                Expanded(child: Obx(() {
                  textEditingController.text = controller.editCommentText.value;
                  return TextField(
                    controller: textEditingController,
                    focusNode: controller.textFocus,
                    decoration: InputDecoration(
                      hintText: controller.commentHintText.value,
                      border: InputBorder.none,
                    ),
                  );
                })),
                IconButton(
                  // 오른쪽에 아이콘
                  icon: Icon(Icons.send), // 아이콘 지정
                  onPressed: () async {
                    if(controller.sendMode == 'add'){
                      await controller.writeComment(
                        // content, productid, userid
                        textEditingController.text, productDetail.id, 1);
                    }
                    else if(controller.sendMode == 'edit'){
                      await controller.editComment(
                        textEditingController.text);
                    }
                    controller.textFocus.unfocus();
                    controller.editCommentText.value = "";
                    controller.reload();
                    textEditingController.text = '';
                    
                  },
                ),
              ],
            ),
          );
        }));
  }
}

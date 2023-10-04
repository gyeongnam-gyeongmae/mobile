import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/views/widget/view_container/post_detail_view.dart';
import 'package:mobile/views/widget/view_container/big_comment_container.dart';
import 'package:mobile/views/widget/view_container/comment_container.dart';

class ProductDetailScrollView extends StatelessWidget {
  final ProductDetailModel productDetail;
  final CommentScrollController controller;

  ProductDetailScrollView(
      {required this.controller, required this.productDetail});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.74,
            child: PostDetailView(productDetail: productDetail),
          ),
          ListView.builder(
            shrinkWrap: true,
            controller: controller.scrollController.value,
            itemCount: controller.count.value + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < controller.data.length) {
                var datum = controller.data[index];
                List<Widget> widgets = [];

                widgets.add(Material(
                  child: CommentContainer(
                    commentId: controller.data[index].id,
                    userId: controller.data[index].userId,
                    content: controller.data[index].content,
                    nickName:
                        controller.data[index].nickName + index.toString(),
                    commentCount: controller.data[index].children.length,
                    createdAt: controller.data[index].createdAt,
                  ),
                ));

                if (datum.children != null) {
                  for (var child in datum.children) {
                    widgets.add(Material(
                      child: BigCommentContainer(
                        commentId: child.id,
                        userId: child.userId,
                        content: child.content,
                        nickName: child.nickName,
                        createdAt: child.createdAt,
                      ),
                    ));
                  }
                }
                return Column(
                  children: widgets,
                );
              }
              if (controller.hasMore.value || controller.isLoading.value) {
                // 데이터 로딩 중에는 로딩 스피너 또는 다른 로딩 UI를 보여줄 수 있습니다.
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                  height: 40,
                );
            },
          ),
        ],
      );
    });
  }
}

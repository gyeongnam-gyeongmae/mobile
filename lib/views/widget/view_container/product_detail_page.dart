import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/views/pages/post_detail_page.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/big_comment_container.dart';
import 'package:mobile/views/widget/view_container/comment_container.dart';

class ProductDetailView extends StatelessWidget {
  final ProductDetailModel productDetail;
  final CommentScrollController controller;

  ProductDetailView({required this.controller, required this.productDetail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: CustomScrollView(
        controller: controller.scrollController.value,
        slivers: [
          SliverToBoxAdapter(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.74,
            child: PostDetailPage(productDetail: productDetail),
          )),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Obx(() {
                List<Widget> widgets = [];
                if (index < controller.data.length) {
                  var datum = controller.data[index];
                  

                  widgets.add(Material(
                    child: CommentContainer(
                      content: controller.data[index].content,
                      nickName: controller.data[index].nickName + index.toString(),
                    ),
                  ));

                  if (datum.children != null) {
                    for (var child in datum.children) {
                      widgets.add(Material(
                        child: BigCommentContainer(
                          content: child.content,
                          nickName: child.nickName,
                        ),
                      ));
                    }
                  }
                }
                if (controller.hasMore.value || controller.isLoading.value) {
                  // 데이터 로딩 중에는 로딩 스피너 또는 다른 로딩 UI를 보여줄 수 있습니다.
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                    children: widgets,
                  );
              });
            },
            childCount: controller.data.length + 1,
          )),
        ],
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}

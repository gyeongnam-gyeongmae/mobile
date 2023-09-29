
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:mobile/controller/comment_scroll_controller.dart";

import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/model/product_detail_model.dart';

import 'package:mobile/views/widget/view_container/main_post.dart';
import 'package:mobile/views/widget/view_container/product_detail_page.dart';

class InfiniteScrollView extends GetView<InfiniteScrollController> {
  @override
  final InfiniteScrollController controller; // 수정: 컨트롤러를 받도록 함

  const InfiniteScrollView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.separated(
            controller: controller.scrollController.value,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              if (index < controller.data.length) {
                return Material(
                  elevation: 2,
                  child: InkWell(
                    onTap: (() async {
                      final ProductDetailModel product = await controller.getProductDetail(controller.data[index].id);
                      Get.delete<CommentScrollController>();
                      CommentScrollController commentScrollcontroller =
                          Get.put(CommentScrollController(productId: product.id));
                      await commentScrollcontroller.loadData();
                      Get.to(()=>ProductDetailView(controller: commentScrollcontroller,productDetail: product));
                    }),
                    child: MainPost(
                      title: controller.data[index].name, 
                      name: controller.data[index].name,//작성자 이름대체
                      price: controller.data[index].price,
                      post_created: controller.changeTime(index),
                      start_price: controller.data[index].price,//현재가,시작가 필요
                      comment_cnt: controller.data[index].viewCount,
                      like_cnt: controller.data[index].likeCount,
                    ),
                  ),
                );
              }

              if (controller.hasMore.value || controller.isLoading.value) {
                return const Center(
                    child: RefreshProgressIndicator()); //로딩안됬을 때 새로고침
              }

              return Container(
                // 맨아래로 갔을 때 보여주는 칸
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      const Text('마지막데이터'),
                      IconButton(
                          onPressed: () {
                            controller.reload();
                          },
                          icon: const Icon(Icons.refresh_outlined))
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => const Divider(),
            itemCount: controller.data.length + 1,
          ),
        ));
  }
}

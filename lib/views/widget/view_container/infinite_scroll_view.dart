import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/views/pages/post_detail_page.dart';
import 'package:mobile/views/widget/view_container/main_post.dart';

class InfiniteScrollView extends GetView<InfiniteScrollController> {
  final InfiniteScrollController controller; // 수정: 컨트롤러를 받도록 함

  InfiniteScrollView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.separated(
            controller: controller.scrollController.value,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              if (index < controller.data.length) {
                var datum = controller.data[index];
                return Material(
                  elevation: 2,
                  child: InkWell(
                    onTap: ((){
                      Get.to(()=>PostDetailPage(),arguments: datum);
                    }),
                    child: MainPost(
                      title: "$datum번째 리트",
                      name: "문준호",
                      price: 1000000,
                      post_created: "내외동 5분전",
                      start_price: "시작가 80,000",
                      comment_cnt: 5,
                      like_cnt: 1,
                    ),
                  ),
                );
              }

              if (controller.hasMore.value || controller.isLoading.value) {
                return Center(child: RefreshProgressIndicator()); //로딩안됬을 때 새로고침
              }

              return Container(
                // 맨아래로 갔을 때 보여주는 칸
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      Text('마지막데이터'),
                      IconButton(
                          onPressed: () {
                            controller.reload();
                          },
                          icon: Icon(Icons.refresh_outlined))
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => Divider(),
            itemCount: controller.data.length + 1,
          ),
        ));
  }
}

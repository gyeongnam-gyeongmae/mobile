import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/views/widget/view_container/big_comment_container.dart';
import 'package:mobile/views/widget/view_container/comment_container.dart';

class CommentScrollView extends GetView<CommentScrollController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Obx(() => Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.separated(
            controller: controller.scrollController.value,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              if (index < controller.data.length) {
                var datum = controller.data[index];
                List<Widget> widgets = [];

                widgets.add(Material(
                  child: CommentContainer(
                      content: controller.data[index].content,
                      nickName: controller.data[index].nickName,
                    ),
                ));

                if(datum.children != null){
                  for(var child in datum.children){
                    widgets.add(Material(
                      child: BigCommentContainer(
                      content: child.content,
                      nickName: child.nickName,
                    ),
                    ));
                  }
                }
                return Column(
                  children: widgets,
                );
              }
              if (controller.isLoading.value) {
                return Center(child: RefreshProgressIndicator());
              }
              return Container(
                child: Center(
                  child: Column(children: [
                    Text('새로고침'),
                    IconButton(
                        onPressed: () {
                          controller.reload();
                        },
                        icon: Icon(Icons.refresh_outlined))
                  ]),
                ),
              );
            },
            separatorBuilder: (_, index) => SizedBox(height: 0),
            itemCount: controller.data.length + 1,
          ))),
    ),
    );
  }
}

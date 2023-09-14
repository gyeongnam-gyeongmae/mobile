import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile/controller/search_textfield_controller.dart';

class SearchAppbar extends GetView<SearchTextfieldController>
    implements PreferredSizeWidget {
  SearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Container(
        margin: EdgeInsets.only(top: 6),
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 54,
          color: Colors.grey,
        ),
      ),
      actions: [
        SizedBox(
          width: 50,
        ),
        Container(
            width: MediaQuery.of(context).size.width / 1.3,
            margin: EdgeInsets.only(right: 30, top: 13),
            child: Obx(() {
              return TextField(
                controller:
                    TextEditingController(text: controller.content.value),
                decoration: InputDecoration(
                  hintText: '             원하는 것을 찾으세요 !',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.search_outlined,
                  ),
                ),
                maxLines: 1, // 단일 줄 입력
                onSubmitted: (value){
                  controller.setContent(value);
                },
              );
            }))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

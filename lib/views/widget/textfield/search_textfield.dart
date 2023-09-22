import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/search_textfield_controller.dart';

class SearchTextfield extends GetView<SearchTextfieldController> {
  final String content;
  SearchTextfield({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        height: 150,
      ),
      Icon(
        Icons.keyboard_arrow_left,
        size: 54,
        color: Colors.grey,
      ),
      SizedBox(
        width: 50,
      ),
      Expanded(
        // TextField에 Expanded 위젯 추가
        child: Obx((){
          return TextField(
          controller: TextEditingController(text: controller.content.value),
          decoration: InputDecoration(
            hintText: '             원하는 것을 찾으세요 !',
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(),
            suffixIcon: Icon(
              Icons.search_outlined,
            ),
          ),
          maxLines: 1, // 단일 줄 입력
        );
        })
      )
    ]);
  }
}
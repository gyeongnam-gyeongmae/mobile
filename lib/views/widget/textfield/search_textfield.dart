import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/search_textfield_controller.dart';

class SearchTextfield extends GetView<SearchTextfieldController> {
  final String content;
  const SearchTextfield({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        height: 150,
      ),
      const Icon(
        Icons.keyboard_arrow_left,
        size: 54,
        color: Colors.grey,
      ),
      Expanded(
          // TextField에 Expanded 위젯 추가
          child: Obx(() {
        return TextField(
          controller: TextEditingController(text: controller.content.value),
          decoration: const InputDecoration(
            hintText: '             원하는 것을 찾으세요 !',
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(),
            suffixIcon: Icon(
              Icons.search_outlined,
            ),
          ),
          maxLines: 1, // 단일 줄 입력
        );
      }))
    ]);
  }
}

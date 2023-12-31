import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/dropdown_controller.dart';

//앱바 오른쪽 드롭다운으로 만들었지만 나중에 지도api호출해서 값 반영해야할 듯
class PopularDropdown extends GetView<DropdownController> {
  final List<String> items;

  PopularDropdown({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // 둥근 모서리 반지름 설정
          border: Border.all(color: Colors.black), // 테두리 색상 설정
        ),
        child: Obx(() {
          return DropdownButton(
            value: controller.popularItem.value,
            icon: Icon(Icons.unfold_more),
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            underline: SizedBox.shrink(),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) {
              controller.setPopularItem(value.toString());
              int index = items.indexOf(value.toString());
              if(index == 0) {
                controller.setPopularBool(true);
              } else {
                controller.setPopularBool(false);
              }
            },
          );
        }));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/controller/add_product_controller.dart';

class ImagePickerContainer extends GetView<AddProductController> {
  final picker = ImagePicker();
  XFile? image;
  List<XFile?> multiImage = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                //카메라로 촬영하기
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 5)
                      ],
                    ),
                    child: IconButton(
                        onPressed: () async {
                          image = await picker.pickImage(
                              source: ImageSource.camera);
                          //카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우, null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images변수로 저장하도록 합니다
                          if (image != null) {
                            controller.images.add(image);
                            controller.update();
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: 30,
                          color: Colors.white,
                        ))),
                //갤러리에서 가져오기
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 5)
                      ],
                    ),
                    child: IconButton(
                        onPressed: () async {
                          multiImage = await picker.pickMultiImage();
                          controller.images.addAll(multiImage);
                          controller.update();
                        },
                        icon: const Icon(Icons.add_photo_alternate_outlined,
                            size: 30, color: Colors.white))),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Obx(() {
                return GridView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount:
                    controller.images.length, //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 사진 개수
                  childAspectRatio: 1 / 1, //사진 의 가로 세로의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                fit: BoxFit.cover, //사진을 크기를 상자 크기에 맞게 조절
                                image: FileImage(File(controller.images[index]!
                                        .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                    )))),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          //삭제 버튼
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.close,
                                color: Colors.white, size: 15),
                            onPressed: () {
                              //버튼을 누르면 해당 이미지가 삭제됨
                              controller.images
                                  .remove(controller.images[index]);
                              controller.update();
                            },
                          ))
                    ],
                  );
                },
              );
              })
            ),
          ],
        ));
  }
}

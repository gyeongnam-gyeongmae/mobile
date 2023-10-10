import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/controller/add_product_controller.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/controller/profile_image_controller.dart';

class ProfileImagePicker extends GetView<ProfileImageController> {
  final picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                            if (controller.image.length == 0)
                              controller.image.add(image);
                            else
                              controller.image[0] = image;
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
                          image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            if (controller.image.length == 0)
                              controller.image.add(image);
                            else
                              controller.image[0] = image;
                            controller.update();
                          }
                        },
                        icon: const Icon(Icons.add_photo_alternate_outlined,
                            size: 30, color: Colors.white))),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 200,
              height: 200,
              child: Obx(() {
                if (controller.image.isNotEmpty) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(controller.image[0]!.path)),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // 삭제 버튼
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.close,
                                color: Colors.white, size: 30),
                            onPressed: () {
                              // 버튼을 누르면 해당 이미지가 삭제됨
                              controller.image.remove(controller.image[0]);
                              controller.update();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(); // 이미지가 없을 때 빈 컨테이너를 반환하여 아무것도 표시하지 않음
                }
              }),
            )
          ],
        ));
  }
}

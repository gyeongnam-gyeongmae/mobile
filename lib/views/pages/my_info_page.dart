import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/controller/profile_image_controller.dart';
import 'package:mobile/views/pages/info_page.dart';
import 'package:mobile/views/widget/picker/image_picker_container.dart';
import 'package:mobile/views/widget/picker/profile_image_picker.dart';

class MyInfoPage extends GetView<ProfileImageController> {
  MyInfoPage({super.key});
  TextEditingController textController = TextEditingController(text: ProfileController.to.getNickname());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 250, 250, 250),
            title: Row(
              children: [
                const Icon(
                  Icons.keyboard_arrow_left,
                  size: 45,
                  color: Colors.grey,
                ),
                const Text(
                  "                   프로필 수정",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                TextButton(
                  onPressed: () async{
                    await controller.uploadProfileImage();
                    await controller.getUserProfile();
                    //여기서 이미지 전송해서 받아올 수 있게 하면될듯
                    Get.off(() => InfoPage());
                  },
                  child: const Text(
                    "완료",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 249, 249, 249), // 버튼의 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0), // 버튼을 둥글게 만듦
                    ),
                    minimumSize: const Size(
                        40.0, 40.0), // 버튼의 최소 크기를 CircleAvatar 크기로 지정
                    side: const BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 1.0), // 테두리 색상과 너비 설정
                  ),
                  onPressed: () {
                    // 버튼 클릭 시 다이얼로그 표시
                    _profileDialog(context).then((value) {
                      if (value == 'OK') {

                      }
                    });
                  },
                  child: Container(
                      width: 80, // 버튼의 너비 설정
                      height: 80, // 버튼의 높이 설정
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // 원 모양의 버튼
                        color:
                            const Color.fromARGB(255, 159, 197, 240), // 배경색 설정
                        border: Border.all(
                          color: Colors.white, // 테두리 색상
                          width: 2.0, // 테두리 두께
                        ),
                      ),
                      child: Obx(() {
                        return CircleAvatar(
                          backgroundImage: controller.image.isEmpty
                              ? NetworkImage(ProfileController.to.getImageUrl())
                              : Image.file(File(controller.image[0]!.path))
                                  .image, //뒤에 변수는 나중에바꾸기
                          maxRadius: 20,
                        );
                      })),
                ),

                const SizedBox(
                  height: 20,
                ),
                // 텍스트를 적고 지울 수 있는 TextField 위젯 예제
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: '이름을 입력하세요',
                    suffixIcon: IconButton(
                      onPressed: () {
                        // TextField 내용을 지우는 로직을 여기에 추가하세요.
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // 원하는 둥근 테두리 반지름 설정
                    ),
                  ),
                  onChanged: (value) {
                    controller.setNickName(value);
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                // 다른 TextField 위젯을 추가할 수 있습니다.
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _profileDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                '프로필 선택',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                Container(
                  width: 300,
                  height: 300,
                  child: ProfileImagePicker(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent[200]),
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                        },
                        child: Text(
                          "프로필 변경",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         primary: Colors.lightBlueAccent[200]),
                    //     onPressed: () {
                    //       Navigator.pop(context, 'basic');
                    //       controller.image.clear();
                    //     },
                    //     child: Text(
                    //       "기본 프로필",
                    //       style: TextStyle(
                    //           fontSize: 15, fontWeight: FontWeight.bold),
                    //     )),
                  ],
                )
              ],
            ));
  }
}

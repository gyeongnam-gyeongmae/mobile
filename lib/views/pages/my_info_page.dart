import 'package:flutter/material.dart';
import 'package:mobile/views/widget/picker/image_picker_container.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

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
                  onPressed: () {},
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ImagePickerDialog(); // ImagePickerDialog 표시
                      },
                    );
                  },
                  child: Container(
                    width: 80, // 버튼의 너비 설정
                    height: 80, // 버튼의 높이 설정
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // 원 모양의 버튼
                      color: const Color.fromARGB(255, 159, 197, 240), // 배경색 설정
                      border: Border.all(
                        color: Colors.white, // 테두리 색상
                        width: 2.0, // 테두리 두께
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/person.jpg"),
                      maxRadius: 20,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                // 텍스트를 적고 지울 수 있는 TextField 위젯 예제
                TextField(
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
                ),
                // 다른 TextField 위젯을 추가할 수 있습니다.
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('사진'),
      actions: [
        SizedBox(
          width: 200,
          height: 90,
          child: ImagePickerContainer(),
        )
      ],
    );
  }
}

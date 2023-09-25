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
                const ImagePickerContainer(),
                const Text(
                  "닉네임",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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

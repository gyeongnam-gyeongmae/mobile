import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 수직 방향 정렬을 왼쪽으로 설정
          children: [
            const Row(
              children: [
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '             원하는 것을 찾으세요 !',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(1),
                      suffixIcon: Icon(
                        Icons.search_outlined,
                      ),
                    ),
                    maxLines: 1, // 단일 줄 입력
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0), // 왼쪽 패딩 추가
              child: Text(
                "최근 검색 기록",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 310.0),
              child: Text(
                "전체 삭제",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    strutStyle: const StrutStyle(fontSize: 16.0),
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                          text: '              플러터',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.grey,
                            decorationThickness: 2.0, // 밑줄 두께 조절
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15, // 텍스트 크기 조절
                          ),
                        ),
                        TextSpan(
                          text: 'asdfdas',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

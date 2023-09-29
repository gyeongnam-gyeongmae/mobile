import 'package:flutter/material.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';

class BigCommentContainer extends StatelessWidget {

  final String content;
  final String nickName;
  BigCommentContainer({required this.content, required this.nickName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(60, 10, 20, 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey), // 아래쪽 라인
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                //이미지 들어가야할 자리
                Text(nickName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(width: 7),
                Text('날짜',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(content),
                )
              ],
            ),
          ],
        ));
  }
}

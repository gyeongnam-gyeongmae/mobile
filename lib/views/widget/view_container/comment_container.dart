import 'package:flutter/material.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';

class CommentContainer extends StatelessWidget {

  final String content;
  final String nickName;
  CommentContainer({required this.content, required this.nickName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(width: 7),
                Text('날짜',
                    style: TextStyle(
                        fontSize: 13,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.chat, color: Colors.black, size: 20),
                        SizedBox(width: 5),
                        Text(
                          "5",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.black, size: 18),
                        SizedBox(width: 5),
                        Text(
                          "7",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ))
              ],
            )
          ],
        ));
  }
}

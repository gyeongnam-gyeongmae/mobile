import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';

class CommentContainer extends GetView<CommentScrollController> {
  final String content;
  final String nickName;
  final int userId;
  final int commentId;
  final int commentCount;
  final DateTime createdAt;
  CommentContainer(
      {required this.commentId,
      required this.userId,
      required this.content,
      required this.nickName,
      required this.commentCount,
      required this.createdAt,
      super.key});

  @override
  Widget build(BuildContext context) {
    String contentText = '';
    int lineLength = 70; // 텍스트 최대 글자수
    for (int i = 0; i < content.length; i += lineLength) {
      int end = i + lineLength;
      if (end > content.length) {
        end = content.length;
      }
      contentText += content.substring(i, end) + '\n';
    }
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
                Text(formatTimeAgo(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Spacer(),
                IconButton(
                  onPressed: () {
                    //1대신에 쿠키의 유저 아이디 비교하기
                    if (userId == 1) {
                      _editCommentDialog(context).then((value) async {
                        if (value == 'add') {
                          controller.setcommentParentId(
                              commentId, "$nickName님에게 답글 쓰기...");
                          controller.textFocus.requestFocus();
                        } else if (value == 'edit') {
                          controller.setEditComment(content, userId, commentId);
                          controller.textFocus.requestFocus();
                        } else if (value == 'remove') {
                          await controller.removeComment(userId, commentId);
                          controller.reload();
                        }
                      });
                    } else {
                      _bigCommentDialog(context).then((value) {
                        if (value == 'OK') {
                          controller.setcommentParentId(
                              commentId, "$nickName님에게 답글 쓰기...");
                          controller.textFocus.requestFocus();
                        }
                      });
                    }
                  },
                  icon: Icon(
                    Icons.keyboard_control_sharp,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(contentText, softWrap: true),
                ))
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
                          commentCount.toString(),
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

  String formatTimeAgo() {
  final now = DateTime.now();
  final dateTime = createdAt.add(Duration(hours: 9)); //서버는 미국시간 기준이어서 9시간 더하기
  final difference = now.difference(dateTime); // 차이 계산
  if (difference.inDays >= 1) {
    return DateFormat('d일 전').format(dateTime);
  } else if (difference.inHours > 1) {
    return DateFormat('H시간 전').format(dateTime);
  } else if (difference.inHours == 1) {
    return '1시간 전';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes}분 전';
  } else {
    return '방금';
  }
  }

  Future<dynamic> _bigCommentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: Text('OK', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'CANCEL');
                    },
                    child:
                        Text('CANCEL', style: TextStyle(color: Colors.black)))
              ],
            ));
  }

  Future<dynamic> _editCommentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'add');
                    },
                    child: Text('대댓글 작성하기',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.grey,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'edit');
                    },
                    child: Text('댓글 수정하기',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.grey,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'remove');
                      },
                      child: Text('댓글 삭제하기',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/controller/profile_controller.dart';

class BigCommentContainer extends GetView<CommentScrollController> {
  final int commentId;
  final int userId;
  final String content;
  final String nickName;
  final DateTime createdAt;
  final String imageUrl;
  const BigCommentContainer(
      {required this.commentId,
      required this.userId,
      required this.content,
      required this.nickName,
      required this.createdAt,
      required this.imageUrl,
      super.key});

  @override
  Widget build(BuildContext context) {
    String contentText = '';
    int lineLength = 35; // 텍스트 최대 글자수
    for (int i = 0; i < content.length; i += lineLength) {
      int end = i + lineLength;
      if (end > content.length) {
        end = content.length;
      }
      contentText += '${content.substring(i, end)}\n';
    }
    return Container(
        padding: const EdgeInsets.fromLTRB(60, 10, 20, 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey), // 아래쪽 라인
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10,),
                Text(nickName,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(width: 7),
                Text(formatTimeAgo(),
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const Spacer(),
                if (userId == ProfileController.to.getId())
                  IconButton(
                    onPressed: () {
                      _editCommentDialog(context).then((value) async {
                        if (value == 'edit') {
                          controller.setEditComment(content, commentId);
                          controller.textFocus.requestFocus();
                          controller.reload();
                        } else if (value == 'remove') {
                          await controller.removeComment(commentId);
                          controller.reload();
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_control_sharp,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(contentText, softWrap: true),
                )
              ],
            ),
          ],
        ));
  }

  String formatTimeAgo() {
    final now = DateTime.now();
    final dateTime =
        createdAt.add(const Duration(hours: 9)); //서버는 미국시간 기준이어서 9시간 더하기
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

  Future<dynamic> _editCommentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'edit');
                    },
                    child: const Text('댓글 수정하기',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Divider(
                    height: 0,
                    color: Colors.grey,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'remove');
                    },
                    child: const Text('댓글 삭제하기',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ));
  }
}

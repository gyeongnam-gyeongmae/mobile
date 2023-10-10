import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/comment_scroll_controller.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';

class CommentContainer extends StatefulWidget {
  final String content;
  final String nickName;
  final int userId;
  final int commentId;
  final int commentCount;
  final DateTime createdAt;
  final int likeCount;
  bool likeState;
  final String imageUrl;
  CommentContainer(
      {required this.commentId,
      required this.userId,
      required this.content,
      required this.nickName,
      required this.commentCount,
      required this.createdAt,
      required this.likeCount,
      required this.likeState,
      required this.imageUrl,
      super.key});
  @override
  _CommentContainerState createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  final CommentScrollController controller =
      Get.find<CommentScrollController>();
  int likeCountState = 0;

      @override
void initState() {
  super.initState();
  likeCountState = widget.likeCount;
}

  @override
  Widget build(BuildContext context) {
    String contentText = '';
    int lineLength = 70; // 텍스트 최대 글자수
    for (int i = 0; i < widget.content.length; i += lineLength) {
      int end = i + lineLength;
      if (end > widget.content.length) {
        end = widget.content.length;
      }
      contentText += '${widget.content.substring(i, end)}\n';
    }
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                  widget.imageUrl,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width:6),
                Text(widget.nickName,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(width: 7),
                Text(formatTimeAgo(),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    //1대신에 쿠키의 유저 아이디 비교하기
                    if (widget.userId == ProfileController.to.getId()) {
                      _editCommentDialog(context).then((value) async {
                        if (value == 'add') {
                          controller.setcommentParentId(widget.commentId,
                              "${widget.nickName}님에게 답글 쓰기...");
                          controller.textFocus.requestFocus();
                        } else if (value == 'edit') {
                          controller.setEditComment(
                              widget.content, widget.commentId);
                          controller.textFocus.requestFocus();
                        } else if (value == 'remove') {
                          await controller.removeComment(
                              widget.commentId);
                          controller.reload();
                        }
                      });
                    } else {
                      _bigCommentDialog(context).then((value) {
                        if (value == 'OK') {
                          controller.setcommentParentId(widget.commentId,
                              "${widget.nickName}님에게 답글 쓰기...");
                          controller.textFocus.requestFocus();
                        }
                      });
                    }
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
                Flexible(
                    child: Container(
                  padding: const EdgeInsets.only(top: 3),
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
                        const Icon(Icons.chat, color: Colors.black, size: 20),
                        const SizedBox(width: 5),
                        Text(
                          widget.commentCount.toString(),
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () async {
                      setState(() {
                        widget.likeState = !widget.likeState;
                      });
                      await controller.changeLike(
                          widget.commentId); // 1 => userId
                      setState(() {
                        likeCountState = widget.likeState
                            ? likeCountState + 1
                            : likeCountState - 1;
                      });
                    },
                    child: Row(
                      children: [
                        widget.likeState
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_outline, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          "${likeCountState}",
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
    final dateTime =
        widget.createdAt.add(const Duration(hours: 9)); //서버는 미국시간 기준이어서 9시간 더하기
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
                  child:
                      Text('대댓글 작성하기', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'CANCEL');
                    },
                    child: Text('취소', style: TextStyle(color: Colors.black)))
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
                    child: const Text('대댓글 작성하기',
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
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ));
  }
}

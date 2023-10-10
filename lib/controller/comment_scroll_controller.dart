import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/model/comment_model.dart';
import 'package:mobile/model/remove_comment_model.dart';
import 'package:mobile/model/write_comment_model.dart';
import 'package:mobile/service/comment_service.dart';

class CommentScrollController extends GetxController{
  var scrollController = ScrollController().obs;
  final CommentService commentService = CommentService("http://203.241.228.51:5000/api/auctions/comments");
  RxList<CommentModel> data = <CommentModel>[].obs;
  var isLoading = false.obs;
  var hasMore = false.obs;
  var count = 0.obs;
  RxInt childCount = 0.obs;
  var productId;
  var commentHintText = "댓글 입력...".obs;
  var editCommentText = "".obs; //edit를 위해서 사용
  var commentId = 0.obs; // add 할땐 commentParentId / edit땐 commentId
  var editUserId = 0.obs; //edit할때 필요한 userId
  var sendMode = "add".obs; // add || edit 확인
  final textFocus = FocusNode();
  RxBool isLike = false.obs;
  CommentScrollController({required this.productId});

  @override
  void onInit(){
    textFocus.addListener((){
      if(!textFocus.hasFocus){
        setcommentParentId(0, "댓글 쓰기...");
        editCommentText.value="";
        update();
      }
    });
    super.onInit();
  }

  Future<void> loadData() async{
    isLoading.value = true;
    try{
      final items = await commentService.getCommentList(productId, ProfileController.to.getId());//userId넣어야함
      // getCommentCount(items);
      getCommentCount(items);
      data.addAll(items);
      data.refresh();
      childCount.value = data.length +1;
      await Future.delayed(Duration(milliseconds:100));
    } catch(e) { print(e.toString());}

    isLoading.value=false;
  }

  reload() async{
    isLoading.value = true;
    count.value = 0;
    data.clear();
    loadData();
    update();
    isLoading.value=false;

  }

  void getCommentCount(List<CommentModel> comments){
    for(CommentModel comment in comments){
      count.value += comment.children.length;
    }
    count.value +=comments.length;
  }

  //댓글 쓰기
  Future<String> writeComment(String content, int id){
    return commentService.writeComment(WriteCommentModel(
                            content: content,
                            userId: ProfileController.to.getId(),
                            parentCommentId: commentId.value), id
              );
  }
  //대댓글을 위한 set
  void setcommentParentId(int commentParentId,String nickName){
    commentId.value = commentParentId;
    commentHintText.value = nickName;
    sendMode.value = "add";
  }

  //댓글 수정
  Future<String> editComment(String content){
    return commentService.editComment(WriteCommentModel(
                            content: content,
                            userId: editUserId.value,
                            parentCommentId: commentId.value));
  }
  //댓글 수정을 위한 set
  void setEditComment(String content, int commentId){
    editCommentText.value = content;
    this.commentId.value = commentId;
    this.editUserId.value = ProfileController.to.getId();
    sendMode.value = "edit";
  }

  Future<void> changeLike(int commentId) async{
    commentService.changeLike(ProfileController.to.getId(), commentId);
  }

  //댓글 삭제
  Future<String> removeComment(int commentId){
    return commentService.removeComment(ProfileController.to.getId(), commentId);
  }

}
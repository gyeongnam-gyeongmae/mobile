import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mobile/model/comment_model.dart';
import 'package:mobile/service/comment_service.dart';

class CommentScrollController extends GetxController{
  var scrollController = ScrollController().obs;
  final CommentService commentService = CommentService("http://203.241.228.51:5000/api/auctions/comments");
  var data = <CommentModel>[].obs;
  var isLoading = false.obs;
  var hasMore = false.obs;
  var count = 0.obs;
  var productId;
  CommentScrollController({required this.productId});

  @override
  void onInit(){
    
    super.onInit();
  }

  Future<void> loadData() async{
    isLoading.value = true;
    try{
      final items = await commentService.getCommentList(productId);
      // getCommentCount(items);
      getCommentCount(items);
      data.addAll(items);
      await Future.delayed(Duration(milliseconds:100));
    } catch(e) { print(e.toString());}

    isLoading.value=false;
  }

  reload() async{
    isLoading.value = true;
    count.value = 0;
    data.clear();
    loadData();

    isLoading.value=false;

  }

  void getCommentCount(List<CommentModel> comments){
    for(CommentModel comment in comments){
      count.value += comment.children.length;
    }
    count.value +=comments.length;
  }

  void scrollToTop() {
    scrollController.value.animateTo(
      0.0,
      duration: Duration(milliseconds: 500), // 이동 애니메이션 지속 시간
      curve: Curves.easeInOut, // 애니메이션 곡선 설정
    );
  }

}
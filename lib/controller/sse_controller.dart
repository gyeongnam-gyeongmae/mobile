import 'dart:async';

import 'package:get/get.dart';
import 'package:sse_channel/sse_channel.dart';

class SseController extends GetxController{
  SseChannel? channel;
  void connect(int id){
    channel = SseChannel.connect(Uri.parse(
        "http://203.241.228.51:5000/api/auctions/$id/bids"));
  }

  void disconnect(){
    if(channel!=null){
      print('해제');
      channel!.sink.close();
      channel = null;
    }
  }

  static SseController get to => Get.find();
}
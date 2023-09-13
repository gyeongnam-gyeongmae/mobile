import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarController extends GetxController with GetSingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Text('판매 상품',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
    ),
    Tab(
      child: Text('상점 후기',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
    ),
    Tab(
      child: Text('찜 목록',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
    )
  ];

  late TabController tabController;

  @override
  void onInit(){
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onClose(){
    tabController.dispose();
    super.onClose();
  }
}
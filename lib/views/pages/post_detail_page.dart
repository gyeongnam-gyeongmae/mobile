import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/model/product_item.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/custom_page_view.dart';

class PostDetailPage extends StatelessWidget {
  final ProductDetailModel productDetail = Get.arguments;

  String changeDifTime(){
    DateTime now = DateTime.now();
    int days = productDetail.closedTime.difference(now).inDays;
    int hours = productDetail.closedTime.difference(now).inHours % 24;
    int minutes = productDetail.closedTime.difference(now).inMinutes % 60;
    String difTime ='';
    if (days > 0) difTime+=' ${days}d';
    if (hours > 0) difTime+=' ${hours}h';
    if(minutes > 0) difTime+=' ${minutes}m';
    return '-' + difTime;
  }
  @override
  Widget build(BuildContext context) {
    String startDate = DateFormat('yyyy-MM-dd HH:mm').format(productDetail.createdTime);
    return Scaffold(
      appBar: MainAppbar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: [
            Center(
              child: Text("${productDetail.name}",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "작성자: ${productDetail.nickname}",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$startDate",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            CustomPageView(),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            fixedSize: Size(
                                (MediaQuery.of(context).size.width) / 2.5, 50)),
                        onPressed: () {},
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "시작가",
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                "${productDetail.price}",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFFFD7575),
                            fixedSize: Size(
                                (MediaQuery.of(context).size.width) / 2.5, 50)),
                        onPressed: () {},
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "현재가",
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                "${productDetail.price}",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        )),
                  ))
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Text("${productDetail.content}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          softWrap: true))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              "${productDetail.viewCount}",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.chat, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              "${productDetail.viewCount}",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.favorite, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              "${productDetail.likeCount}",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                  ],
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    changeDifTime(),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                width: (MediaQuery.of(context).size.width) / 3.5,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    onPressed: () {},
                    child: Text('+100')),
              ),
              Container(
                width: (MediaQuery.of(context).size.width) / 3.5,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 168, 203, 255),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    onPressed: () {},
                    child: Text('+1000')),
              ),
              Container(
                width: (MediaQuery.of(context).size.width) / 3.5,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF95FC93),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    onPressed: () {},
                    child: Text('+10000')),
              ),
            ]),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}

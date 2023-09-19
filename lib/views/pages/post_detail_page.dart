import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';
import 'package:mobile/views/widget/view_container/custom_page_view.dart';

class PostDetailPage extends StatelessWidget {
  PostDetailPage({super.key});
  var datum = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: [
            Center(
              child: Text("$datum",
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
                        "작성자: 문준호 줍줍",
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "2023년 9월 5일 내외동",
                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),
                    ),
                  )),
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
                                "10000",
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
                                "52300",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        )),
                  ))
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                            "아 아무것도 하기 싫다...아 아무것도 하기 싫다...아 아무것도 하기 싫다...아 아무것도 하기 싫다...아 아무것도 하기 싫다...아 아무것도 하기 싫다...아 아무것도 하기 싫다...",
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                            softWrap: true)))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          "37",
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
                          "5",
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
                          "5",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ))
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

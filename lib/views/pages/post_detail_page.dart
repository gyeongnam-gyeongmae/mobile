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

  PostDetailPage({super.key});

  String changeDifTime() {
    DateTime now = DateTime.now();
    int days = productDetail.closedTime.difference(now).inDays;
    int hours = productDetail.closedTime.difference(now).inHours % 24;
    int minutes = productDetail.closedTime.difference(now).inMinutes % 60;
    String difTime = '';
    if (days > 0) difTime += ' ${days}d';
    if (hours > 0) difTime += ' ${hours}h';
    if (minutes > 0) difTime += ' ${minutes}m';
    return '-$difTime';
  }

  @override
  Widget build(BuildContext context) {
    String startDate =
        DateFormat('yyyy-MM-dd HH:mm').format(productDetail.createdTime);
    return Scaffold(
      appBar: const MainAppbar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: [
            Center(
              child: Text(productDetail.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 23)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "작성자: ${productDetail.nickname}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      startDate,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            CustomPageView(),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            fixedSize: Size(
                                (MediaQuery.of(context).size.width) / 2.5, 50)),
                        onPressed: () {},
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "시작가",
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                "${productDetail.price}",
                                style: const TextStyle(fontSize: 17),
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
                            backgroundColor: const Color(0xFFFD7575),
                            fixedSize: Size(
                                (MediaQuery.of(context).size.width) / 2.5, 50)),
                        onPressed: () {},
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "현재가",
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                "${productDetail.price}",
                                style: const TextStyle(fontSize: 17),
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
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Text(productDetail.content,
                          style: const TextStyle(
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
                            const Icon(Icons.person, color: Colors.black),
                            const SizedBox(width: 5),
                            Text(
                              "${productDetail.viewCount}",
                              style: const TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(Icons.chat, color: Colors.black),
                            const SizedBox(width: 5),
                            Text(
                              "${productDetail.viewCount}",
                              style: const TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.favorite, color: Colors.black),
                            const SizedBox(width: 5),
                            Text(
                              "${productDetail.likeCount}",
                              style: const TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                  ],
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    changeDifTime(),
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width) / 3.5,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    onPressed: () {},
                    child: const Text('+100')),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width) / 3.5,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 168, 203, 255),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    onPressed: () {},
                    child: const Text('+1000')),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width) / 3.5,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF95FC93),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    onPressed: () {},
                    child: const Text('+10000')),
              ),
            ]),
          ],
        ),
      ),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}

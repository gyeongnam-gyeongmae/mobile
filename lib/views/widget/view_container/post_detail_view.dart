import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/infinite_scroll_conterller.dart';
import 'package:mobile/controller/sse_price_controller.dart';
import 'package:mobile/model/product_detail_model.dart';
import 'package:mobile/views/widget/view_container/custom_page_view.dart';

class PostDetailView extends StatefulWidget {
  final ProductDetailModel productDetail;
  final int commentCount;
  bool likeState;
  PostDetailView(
      {required this.productDetail,
      required this.commentCount,
      required this.likeState});

  @override
  _PostDetailViewState createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  final InfiniteScrollController controller =
      Get.find<InfiniteScrollController>();
  final SsePriceController priceController = Get.find<SsePriceController>();
  int likeCountState = 0;

  @override
  void initState() {
    super.initState();
    likeCountState = widget.productDetail.likeCount;
  }

  String changeDifTime() {
    DateTime now = DateTime.now();
    DateTime dateTime = widget.productDetail.closedTime.add(Duration(hours: 9));
    bool isNegative = dateTime.difference(now).isNegative;
    int days = dateTime.difference(now).inDays.abs();
    int hours = (dateTime.difference(now).inHours % 24).abs();
    int minutes = (dateTime.difference(now).inMinutes % 60).abs();
    String difTime = '';
    String negative = isNegative ? "+ " : "- ";
    difTime += negative;
    if (days > 0) difTime += ' ${days}d';
    if (hours > 0) difTime += ' ${hours}h';
    if (minutes > 0) difTime += ' ${minutes}m';
    return difTime;
  }

  @override
  Widget build(BuildContext context) {
    String startDate = DateFormat('yyyy-MM-dd HH:mm')
        .format(widget.productDetail.createdTime.add(Duration(hours: 9)));
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Column(
        children: [
          Center(
            child: Text("${widget.productDetail.name}",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "작성자: ${widget.productDetail.nickname}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "$startDate",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          CustomPageView(
            images: widget.productDetail.images,
          ),
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
                            Text(
                              "시작가",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              "${widget.productDetail.price}",
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
                                backgroundColor: const Color(0xFFFD7575),
                                fixedSize: Size(
                                    (MediaQuery.of(context).size.width) / 2.5,
                                    50)),
                            onPressed: () {},
                            child: Center(child: Obx(() {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "현재가",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    //priceController.price
                                    "${priceController.price}",
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              );
                            })))))
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 90,
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: Text("${widget.productDetail.content}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      softWrap: true))
            ],
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
                            "${widget.productDetail.viewCount}",
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
                            "${widget.commentCount}",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          widget.likeState = !widget.likeState;
                        });
                        print(widget.likeState);
                        print(likeCountState);
                        await controller.changeLike(
                            widget.productDetail.id); // 1 => userId
                        setState(() {
                          likeCountState = widget.likeState
                              ? likeCountState + 1
                              : likeCountState - 1;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          widget.likeState
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_outline,
                                  color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            "$likeCountState",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ))
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
            SizedBox(
              width: (MediaQuery.of(context).size.width) / 3.5,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    _PriceDialog(context, priceController.price.value + 100)
                        .then((value) {
                      if (value == 'OK') {
                        controller.addPrice(widget.productDetail.id,
                            priceController.price.value + 100); //id, price
                      }
                    });
                  },
                  child: const Text('+100')),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width) / 3.5,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 168, 203, 255),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    _PriceDialog(context, priceController.price.value + 1000)
                        .then((value) {
                      if (value == 'OK') {
                        controller.addPrice(widget.productDetail.id,
                            priceController.price.value + 1000); //id, price
                      }
                    });
                  },
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
                  onPressed: () {
                    _PriceDialog(context, priceController.price.value + 10000)
                        .then((value) {
                      if (value == 'OK') {
                        controller.addPrice(widget.productDetail.id,
                            priceController.price.value + 10000); //id, price
                      }
                    });
                  },
                  child: const Text('+10000')),
            ),
          ]),
        ],
      ),
    );
  }

  Future<dynamic> _PriceDialog(BuildContext context, int price) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('입찰하기'),
              content: Text('$price원에 입찰하겠습니까?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: Text('입찰', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'CANCEL');
                    },
                    child: Text('취소', style: TextStyle(color: Colors.black)))
              ],
            ));
  }
}

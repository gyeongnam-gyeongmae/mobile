import 'package:flutter/material.dart';

//게시글 컨테이너
class MainPost extends StatelessWidget {
  final String title;
  final String name;
  final int price;
  final String post_closed;
  final int start_price;
  final int comment_cnt;
  final int like_cnt;
  final String image_url;
  const MainPost({
    required this.title,
    required this.name,
    required this.price,
    required this.post_closed,
    required this.start_price,
    required this.comment_cnt,
    required this.like_cnt,
    required this.image_url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        height: 120,
        width: MediaQuery.of(context).size.width - 20,
        child: InkWell(
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 90,
                    child: image_url.isEmpty
                        ? Image.asset('assets/images/test.png',
                            fit: BoxFit.cover)
                        : Image.network('$image_url', fit: BoxFit.cover),
                  ),
                  if(post_closed == "경매 마감")
                    Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      color: Colors.black.withOpacity(0.7), // 배경색 및 투명도 조절
                      child: Text(
                        "판매완료",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10), // 가로 여백 추가
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(price.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)))))
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("$post_closed",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(price.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  const Icon(Icons.person, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text(
                                    comment_cnt.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(Icons.favorite,
                                      color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text(
                                    like_cnt.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

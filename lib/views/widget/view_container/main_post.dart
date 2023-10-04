import 'package:flutter/material.dart';

//게시글 컨테이너
class MainPost extends StatelessWidget {
  final String title;
  final String name;
  final int price;
  final String post_created;
  final int start_price;
  final int comment_cnt;
  final int like_cnt;
  const MainPost({
    required this.title,
    required this.name,
    required this.price,
    required this.post_created,
    required this.start_price,
    required this.comment_cnt,
    required this.like_cnt,
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
              Container(
                child: Image.asset('assets/images/test.png',
                    width: 100, height: 90, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10), // 가로 여백 추가
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(name,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(price.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)))))
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(post_created,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(height: 4),
                    Text(price.toString(),
                        style: TextStyle(
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
                                  Icon(Icons.person, color: Colors.black),
                                  SizedBox(width: 5),
                                  Text(
                                    comment_cnt.toString(),
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
                                    like_cnt.toString(),
                                    style: TextStyle(color: Colors.black),
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

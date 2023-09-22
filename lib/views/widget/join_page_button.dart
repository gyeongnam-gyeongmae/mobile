import 'package:flutter/material.dart';

class JoinPageButton extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final String text;

  const JoinPageButton({
    Key? key, // key 속성을 추가하고, super.key 대신에 key를 사용합니다.
    required this.height,
    required this.width,
    required this.padding,
    required this.text,
    required Null Function() onTap,
  }) : super(key: key); // 슈퍼 클래스의 생성자를 호출할 때 key 속성을 전달합니다.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: EdgeInsets.only(left: padding),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0), // 라운드 모서리 반경 설정
            ),
            backgroundColor: const Color.fromARGB(255, 156, 119, 248),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

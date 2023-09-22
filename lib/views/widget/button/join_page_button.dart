import 'package:flutter/material.dart';

class JoinPageButton extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final String text;
  final VoidCallback? onTap; // VoidCallback 형식의 onTap 추가

  const JoinPageButton({
    Key? key,
    required this.height,
    required this.width,
    required this.padding,
    required this.text,
    this.onTap, // onTap 속성 추가
  }) : super(key: key);

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
              borderRadius: BorderRadius.circular(9.0),
            ),
            backgroundColor: const Color.fromARGB(255, 156, 119, 248),
          ),
          onPressed: onTap, // onTap 속성 사용
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

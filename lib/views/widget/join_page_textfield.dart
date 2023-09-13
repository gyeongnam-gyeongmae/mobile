import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  String? hintText; // 변경 가능한 변수로 선언
  final double width;
  final double height;
  final double padding;

  TextFieldWidget({
    Key? key,
    this.hintText,
    required this.width,
    required this.height,
    required this.padding,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _isFocused = false;
  double vertical = 30;
  final TextEditingController _textEditingController =
      TextEditingController(); // 컨트롤러 추가

  @override
  void dispose() {
    // State가 dispose될 때 컨트롤러를 해제
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: widget.padding, right: widget.padding),
          child: TextFormField(
            controller: _textEditingController, // 컨트롤러 연결
            decoration: InputDecoration(
              labelText: _isFocused ? null : widget.hintText,
              labelStyle: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),

              contentPadding: EdgeInsets.only(
                top: vertical,
              ), // 원하는 패딩을 설정
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _textEditingController.clear(); // TextFormField의 내용을 지움
                    _isFocused = false;
                  });
                },
                icon: const Icon(Icons.cancel_outlined),
              ),

              suffixIconConstraints: const BoxConstraints(
                maxHeight: 100, // 아이콘의 최대 높이 설정
                maxWidth: 40, // 아이콘의 최대 너비 설정
              ),
            ),
            onTap: () {
              setState(() {
                vertical = 10;
                _isFocused = true;
              });
            },
            onChanged: (text) {
              setState(() {
                _isFocused = text.isNotEmpty;
              });
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:mobile/controller/join_controller.dart';

class PhoneText extends StatefulWidget {
  String? hintText;
  final double width;
  final double height;
  final double padding;

  PhoneText({
    Key? key,
    this.hintText,
    required this.width,
    required this.height,
    required this.padding,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<PhoneText> {
  bool _isFocused = false;
  double vertical = 30;
  final TextEditingController _textEditingController = TextEditingController();
  final JoinController joinController =
      Get.find<JoinController>(); // JoinController 인스턴스 찾기
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: widget.padding, right: widget.padding),
          child: TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              labelText: _isFocused ? null : widget.hintText,
              labelStyle: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.only(
                top: vertical,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _textEditingController.clear();
                    _isFocused = false;
                  });
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 100,
                maxWidth: 40,
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
                // 수정: onTextChanged를 호출하여 텍스트를 상위 위젯에 전달

                joinController.setAuthenticationNumber(text);
              });
            },
          ),
        ),
      ),
    );
  }
}

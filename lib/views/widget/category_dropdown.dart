import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdown();
}

//앱바 오른쪽 드롭다운으로 만들었지만 나중에 지도api호출해서 값 반영해야할 듯
class _CategoryDropdown extends State<CategoryDropdown> {
  final _category = ['의류', '디지털', '가구', '기타'];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedCategory = _category[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DropdownButton(
              value: _selectedCategory,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              underline: SizedBox.shrink(),
              items: _category
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                if(value != '카테고리'){
                  setState(() {
                  _selectedCategory = value!;
                });
                }
              },
            ),
    );
  }
}

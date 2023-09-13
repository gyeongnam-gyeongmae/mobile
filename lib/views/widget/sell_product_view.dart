import 'package:flutter/material.dart';
import 'package:mobile/views/widget/infinite_scroll_view.dart';

class SellProductView extends StatefulWidget {
  const SellProductView({super.key});

  @override
  State<SellProductView> createState() => _SellProductViewState();
}

class _SellProductViewState extends State<SellProductView> {
  int selectedId = 1;
  final List<Widget> myContainers = [
    Container(child: InfiniteScrollView()),
    Container(child: Text('판매중')),
    Container(child: Text('예약중')),
    Container(child: Text('판매 완료'))
  ];

  //내정보 페이지에서 버튼 클릭시 아래에 표시할 컨테이너, 위젯list로 관리하면 될듯
  Widget _buildContainer(){ 
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: myContainers[selectedId],

          );
  }
  //판매 상품에 만들어진 버튼 디자인
  Widget _containerSelectorButton(int id, String text){ 
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: id == selectedId ? Colors.black : Colors.white,
          foregroundColor: id == selectedId ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          )
        ),
        onPressed: () {
          setState(() {
            selectedId = id;
          });
        },
        child: Text(text)
      );
  }
  
  //버튼 생성
  Widget _containerSelector(){
    return Container(
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _containerSelectorButton(0, '전체'),
          _containerSelectorButton(1, '판매중'),
          _containerSelectorButton(2, '예약중'),
          _containerSelectorButton(3, '판매 완료')
        ]
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _containerSelector(),
        Expanded(child: _buildContainer())
      ],
    );
  }
}
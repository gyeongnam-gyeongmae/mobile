import 'package:flutter/material.dart';
import 'package:mobile/views/widget/infinite_scroll_view.dart';

class BuyProductView extends StatelessWidget {
  const BuyProductView({super.key});

  Widget _containerSelector(BuildContext context,int cnt) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, left: 25),
              child: Text('상품 $cnt건',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Divider(color: Colors.grey, thickness: 1),
            )
          ],
        ));
  }
  Widget _buildContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Container(child: InfiniteScrollView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
          _containerSelector(context, 0),
          Expanded(child: _buildContainer())],
        );
  }
}
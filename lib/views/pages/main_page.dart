import 'package:flutter/material.dart';
import 'package:mobile/views/widget/infinite_scroll_view.dart';
import 'package:mobile/views/widget/main_bottom_bar.dart';
import 'package:mobile/views/widget/main_appbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {},
                        child: Text('의류')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {},
                        child: Text('디지털')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {},
                        child: Text('가구')),
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () {},
                        child: Text('기타')),
                  )
                ]),
          ),
          Expanded(child: InfiniteScrollView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}

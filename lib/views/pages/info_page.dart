import 'package:flutter/material.dart';
import 'package:mobile/views/widget/bar/info_tabbar.dart';
import 'package:mobile/views/widget/bar/main_appbar.dart';
import 'package:mobile/views/widget/bar/main_bottom_bar.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/test.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text('문준호',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
          InfoTabbar(),
        ]),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}

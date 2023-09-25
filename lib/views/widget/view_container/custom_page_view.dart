import 'package:flutter/material.dart';
import 'package:mobile/views/widget/custom_smooth_indicator.dart';

class CustomPageView extends StatelessWidget {
  CustomPageView({super.key});
  final List<String> images = <String>['kakao.png', 'naver.png', 'test.png'];

  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 30, // 원하는 크기로 조정
          height: 200, // 원하는 크기로 조정
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: Image.asset(
                'assets/images/${images[index]}',
                fit: BoxFit.cover,
              ));
            },
          ),
        ),
        CustomSmoothIndicator(pageController: pageController),
      ],
    );
  }
}

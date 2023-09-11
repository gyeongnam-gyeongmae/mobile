import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothIndicator extends StatelessWidget {
  final PageController pageController; // CustomPageView에서 전달된 컨트롤러

  CustomSmoothIndicator(
      {required this.pageController}); // 생성자를 통해 컨트롤러를 받음/ 생성자를 통해 컨트롤러를 받습니다.

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: SmoothPageIndicator(
          controller: pageController,
          count: 3,
          effect: WormEffect(
              activeDotColor: Theme.of(context).primaryColor,
              dotColor: Theme.of(context).colorScheme.background,
              radius: 4,
              dotHeight: 8,
              dotWidth: 8),
          onDotClicked: (index) {}),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile/views/widget/custom_smooth_indicator.dart';

class CustomPageView extends StatelessWidget {
  final List<String> images;
  CustomPageView({required this.images, super.key});
  //이부분을 컨트롤러로 받아와서 넣으면 될 듯함

  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 30, // 원하는 크기로 조정
          height: 150, // 원하는 크기로 조정
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: images.isEmpty ? 1 : images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: images.isEmpty
                      ? Image.asset('assets/images/test.png',
                          fit: BoxFit.cover)
                      : Image.network('${images[index]}',
                          fit:BoxFit.contain)
                    );
            },
          ),
        ),
        CustomSmoothIndicator(pageController: pageController,
          imageLength: images.isEmpty ? 1 : images.length,),
      ],
    );
  }
}

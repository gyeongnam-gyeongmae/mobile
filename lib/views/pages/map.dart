import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/map_controller.dart';
import 'package:mobile/models/map_model.dart';

class NaverMapTest extends StatefulWidget {
  const NaverMapTest({super.key});

  @override
  _NaverMapTestState createState() => _NaverMapTestState();
}

class _NaverMapTestState extends State<NaverMapTest> {
  Position? positionData; // 위치 정보를 저장할 변수
  final MapController mapController = Get.find<MapController>();
  bool isLoading = false; // 다이얼로그가 표시되는지 여부를 나타내는 변수
  late Future<MapModel?> model;
  @override
  void initState() {
    super.initState();

    // 위치 정보를 가져와서 변수에 저장
    _getCurrentLocation();
  }

  // 위치 정보를 가져오는 함수
  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      positionData = position;
      model = mapController.postLocation(positionData!);
      isLoading = true;
    });

    return position;
  }

  void closeDialog() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    return GestureDetector(
      onTap: () {
        if (isLoading) {
          closeDialog(); // 다이얼로그 닫기
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: positionData != null
                      ? const NLatLng(
                          34.8806,
                          128.6211,
                        )
                      : const NLatLng(34.8806, 128.6211), // 위치 정보가 없는 경우 기본값 설정
                  zoom: 10,
                  bearing: 0,
                  tilt: 0,
                ),
                scrollGesturesFriction: 0.5,
                zoomGesturesFriction: 0.5,
                rotationGesturesFriction: 0.5,
                locationButtonEnable: true,
              ),
              forceGesture: false,
              onMapReady: (controller) {},
              onMapTapped: (point, latLng) {},
              onSymbolTapped: (symbol) {},
              onCameraChange: (position, reason) {},
              onCameraIdle: () {},
              onSelectedIndoorChanged: (indoor) {},
            ),
            if (isLoading)
              FutureBuilder<MapModel?>(
                future: model,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // 데이터를 기다리는 동안 보여줄 위젯
                    return Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // 에러 발생 시 처리
                    return Text('에러 발생: ${snapshot.error}');
                  } else {
                    // 데이터가 준비되면 UI에 출력
                    final mapModel = snapshot.data;
                    if (mapModel != null) {
                      mapController.city.value = mapModel.city;
                      return Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text(
                                mapModel.city, // 원하는 데이터 필드에 접근

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Text('데이터가 없습니다.');
                    }
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

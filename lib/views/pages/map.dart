import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}

class NaverMapTest extends StatelessWidget {
  const NaverMapTest({super.key});

  @override
  Widget build(BuildContext context) {
    late Future<Position> position = getCurrentLocation();
    return Scaffold(
      body: FutureBuilder<Position>(
        future: position,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final positionData = snapshot.data!;
            return NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: NLatLng(
                    positionData.latitude, // 수정된 부분: latitude
                    positionData.longitude,
                  ),
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
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

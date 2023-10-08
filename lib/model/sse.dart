import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class Sse {
  late http.Client _client;
  void subscribe(int productId) async {
    print("Subscribing..");
    try {
      _client = http.Client();

      var request = new http.Request(
          "GET", Uri.parse("http://203.241.228.51:5000/api/auctions/$productId/bids"));
      request.headers["Cache-Control"] = "no-cache";
      request.headers["Accept"] = "text/event-stream";
      request.headers["Connection"] = "keep-alive";
      request.headers["Keep-Alive"] = "timeout=60";

      Future<http.StreamedResponse> response = _client.send(request);
      print("Subscribed!");

      response.asStream().listen((streamedResponse) {
        streamedResponse.stream.listen((data) {
          print("Received data:$data");
        });
      });
    } catch (e) {
      print("Caught $e");
    }
  }
  void unsubscribe() {
	_client.close();
  print("연결해제");
  }
}

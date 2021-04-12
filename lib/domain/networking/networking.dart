import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url, this.auth, this.id});
  final String auth;
  final String url;
  final String id;

  Future startTracing() async {
    http.Response response = await http.post(
        Uri.parse('$url/devices/$id/start'),
        body: null,
        headers: {'Authorization': auth});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getData() async {
    http.Response response = await http
        .get(Uri.parse('$url/devices/$id'), headers: {'Authorization': auth});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future endTracing() async {
    http.Response response = await http.post(Uri.parse('$url/devices/$id/stop'),
        body: null, headers: {'Authorization': auth});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

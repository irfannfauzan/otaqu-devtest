import 'dart:convert';
import 'dart:io';

import 'package:otaqu_devtest/common/secure_storage.dart';
import 'package:otaqu_devtest/models/destinationModels.dart';
import 'package:http/http.dart' as http;

class GetDestinationServices {
  final String uri = "http://115.85.80.34:4100/destination";

  Future<List<DestinationModels>> getDestination() async {
    final String? token = await Keystore.read('token');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
    };
    final response = await http.get(Uri.parse(uri), headers: headers);
    print("status code : ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> listJsonData = jsonData['data'];
      List<DestinationModels> list =
          listJsonData.map((e) => DestinationModels.fromJson(e)).toList();
      return list;
    } else {
      return [];
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:otaqu_devtest/common/secure_storage.dart';
import 'package:otaqu_devtest/models/availModels.dart';

class AvailServices {
  final String _uri = "http://115.85.80.34:4100/avail";

  Future<DataAvailModels> getData(int idDestination) async {
    final String? token = await Keystore.read('token');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      // 'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
    };
    final body = jsonEncode({
      "type_source": "location",
      "type_id": 3,
      "destination_id": idDestination,
      "min_price": 0,
      "max_price": 10000000000,
      "page": 1,
      "order_by": "lowest",
      "reference": "search"
    });
    final response =
        await http.post(Uri.parse(_uri), headers: headers, body: body);
    print('response status code : ${response.statusCode}');
    if (response.statusCode == 200) {
      String jsonData = response.body.toString();
      var json = jsonDecode(jsonData);
      return DataAvailModels.fromJson(json);
    } else {
      return DataAvailModels(
          availModels: AvailModels(totalPage: 0, currentPage: 0, list: []));
    }
  }
}

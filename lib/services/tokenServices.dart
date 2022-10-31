import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:otaqu_devtest/models/tokenModels.dart';

class GetTokenService {
  String url = 'http://115.85.80.34/utilization/api/auth/login';

  Future<TokenModels> postToken() async {
    final response = await http.post(Uri.parse(url),
        body: {'username': 'otaqu', 'password': 'qwerty'});
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return TokenModels.fromJson(jsonData);
    } else {
      throw Exception();
    }
  }
}

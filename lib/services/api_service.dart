import 'dart:convert';

import 'package:fake_store/models/api_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> login(String userN, String pass) {
    return http.post(Uri.parse(baseUrl + "/auth/login"),
        body: {'username': userN, 'password': pass}).then((data) {
      if (data.statusCode == 201) {
        final jsonData = json.decode(data.body);

        return Future<dynamic>(jsonData);
      }
      return APIResponse<String>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<String>(error: true, errorMessage: 'An error occured'));
  }
}

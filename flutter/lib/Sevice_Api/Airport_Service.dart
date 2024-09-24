import 'dart:convert';

import 'package:flutter_application_4/model/Ariport.dart';
import 'package:http/http.dart' as http;

var url = "http://localhost:1002/api/v1/Airport";

class AriportService {
  Future<Map<String, List<Ariport>>?> getMenu() async {
    try {
      final response =
          await http.get(Uri.parse("$url/all"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        Map<String, List<Ariport>> ariport = {};

        data.forEach((key, value) {
          ariport[key] =
              (value as List).map((item) => Ariport.fromMap(item)).toList();
        });
        return ariport;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}

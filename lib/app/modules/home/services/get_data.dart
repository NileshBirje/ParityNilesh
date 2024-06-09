import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application_nilesh/app/utils/common_functions.dart';
import 'package:http/http.dart' as http;

class GetData {
  Future<Map<String, dynamic>> getData(String url) async {
    var headers = {'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9'};

    var dio = Dio();
    var response = await dio.request(
      url, // 'http://stagingauth.desidime.com/v4/home/new?per_page=10&page=1&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    Func().dPrint('resp:: ${response.data}');
    if (response.statusCode == 200) {
      return response.data;
    }
    return {};
  }
}

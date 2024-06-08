import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application_nilesh/app/data/common_functions.dart';
import 'package:http/http.dart' as http;

class GetData {
  Future<http.Response> getData(String url) async {
    var uri = Uri.parse(url);
    // final headers = {
    //   'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9',
    // };
    final dio = Dio();
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      // Add a custom header to the request
      options.headers['X-Desidime-Client'] = '08b4260e5585f282d1bd9d085e743fd9';
      return handler.next(options);
    },
  ),
);
    var response = await dio.get(
      url,
      
    );
    Func().dPrint('resp:: ${response.data}');

    return response.data;
  }
}

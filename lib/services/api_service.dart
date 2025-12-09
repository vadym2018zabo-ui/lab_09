import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart'; // ⬅️ обов’язково для Windows

class ApiService {
  late Dio _dio;
  final String baseUrl;

  ApiService({required this.baseUrl}) {
    _dio = Dio();
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<bool> sendForm(String endpoint, Map<String, dynamic> data) async {
    try {
      final resp = await _dio.post('$baseUrl/$endpoint', data: data);
      print('Response status: ${resp.statusCode}');
      return resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 400;
    } catch (e) {
      print('SendForm error: $e');
      return false;
    }
  }
}



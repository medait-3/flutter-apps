import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static dioInit() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true),
    );
  }

  static Future<Response<dynamic>> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flixflex/webServices/Constants/Endpoints/api_key.dart';
import 'package:flixflex/webServices/Constants/base_url.dart';

class DioHelper {
  static Dio? dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3',
          receiveDataWhenStatusError: true,
          headers: {
            'api_key': apiKey,
          }),
    );
  }

  static Future<Response> getData(
          {required String endPoint,
          String lang = 'en-US',
          int page = 1}) async =>
      await Dio().get(
        "$baseUrl$endPoint?api_key=$apiKey&language=$lang&page=$page",
      );

  static Future<Response> getSearchData(
          {required String endPoint,
          required String query,
          String lang = 'en-US',
          int page = 1}) async =>
      await Dio().get(
        "$baseUrl$endPoint?api_key=$apiKey&language=$lang&page=$page&query=$query",
      );
}

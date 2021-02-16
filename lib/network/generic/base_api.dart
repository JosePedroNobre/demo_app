import 'package:dio/dio.dart';

class BaseApi {
  Dio dio = Dio();

  BaseApi() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          options.headers.addAll({
            "Accept": "application/json",
            "content-type": "application/json"
          });
          return options;
        },
        onResponse: (Response response) async {
          return response;
        },
        onError: (DioError e) async {},
      ),
    );
  }
}

import 'package:dio/dio.dart';

class DioClient {
  // static final DioClient _instance = DioClient._internal();
  static Dio? _dio;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "", // TODO change base url
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // _dio?.interceptors.add(
    //   LogInterceptor(request: true, responseBody: true, error: true),
    // );
  }

  static Dio get dio {
    if (_dio == null) {
      DioClient._internal();
    }
    return _dio!;
  }
}

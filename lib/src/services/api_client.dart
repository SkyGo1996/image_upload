import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_upload_test/src/services/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = DioClient.dio;
  return ApiClient(dio);
}

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;
}

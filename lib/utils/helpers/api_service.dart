import 'dart:io';

import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:crashorcash/utils/helpers/dio_interceptor.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:dio/dio.dart';
// import 'package:get/get.dart';

enum DioMethod { post, get, put, patch, delete }

class ApiService {
  ApiService._singleton();

  static final ApiService instance = ApiService._singleton();

  String get baseUrl {
    return AppConstants.baseUrl;
  }

  String get token {
    return UserTokenManager.instance.accessToken;
  }

  Future<Response> request(
    String endPoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    formData,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType ?? Headers.formUrlEncodedContentType,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    )..interceptors.add(Logging());

    switch (method) {
      case DioMethod.post:
        return dio.post(endPoint, data: param ?? formData);
      case DioMethod.get:
        return dio.post(endPoint, queryParameters: param);
      case DioMethod.put:
        return dio.post(endPoint, data: param ?? formData);
      case DioMethod.delete:
        return dio.post(endPoint, data: param ?? formData);
      default:
        return dio.post(endPoint, data: param ?? formData);
    }
  }
}

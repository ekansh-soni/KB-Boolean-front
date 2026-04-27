import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../services/shared_preference_helper.dart';
import 'project_settings.dart';

class NetworkService {
  late final Dio _dio;

  // bool _isRefreshing = false;
  // final List<Future<void> Function()> _retryQueue = [];

  NetworkService() {
    final options = BaseOptions(
      baseUrl: ProjectSettings.baseUrl,
      connectTimeout: Duration(milliseconds: ProjectSettings.connectionTimeout),
      receiveTimeout: Duration(milliseconds: ProjectSettings.receiveTimeout),
      responseType: ResponseType.json,
      validateStatus: (status) => status != null && status < 500,
    );

    _dio = Dio(options);

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        /// ================= REQUEST =================
        onRequest: (options, handler) {
          final token = SharedPreferencesHelper().getString('accessToken');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          options.headers['Device-Type'] = 'app';
          handler.next(options);
        },

        /// ================= RESPONSE =================
        onResponse: (response, handler) async {
          if (response.statusCode == 401 &&
              response.data is Map &&
              response.data['message'] == 'Token expired' &&
              !response.requestOptions.path.contains("refreshToken")) {
            // final requestOptions = response.requestOptions;

            /*if (!_isRefreshing) {
              _isRefreshing = true;

              final refreshed = await refreshToken();

              _isRefreshing = false;

              if (refreshed) {
                // Retry queued requests
                for (var retry in _retryQueue) {
                  await retry();
                }
                _retryQueue.clear();

                // Retry original request
                final newResponse = await _dio.fetch(requestOptions);
                return handler.resolve(newResponse);
              }
            } else {
              // Wait for refresh to complete
              _retryQueue.add(() async {
                final newResponse = await _dio.fetch(requestOptions);
                handler.resolve(newResponse);
              });

              return;
            }*/
          }

          handler.next(response);
        },

        /// ================= ERROR =================
        onError: (DioException e, handler) {
          debugPrint("===== DIO ERROR =====");
          debugPrint("Type: ${e.type}");
          debugPrint("Message: ${e.message}");
          debugPrint("Error: ${e.error}");
          debugPrint("Response: ${e.response}");
          debugPrint("=====================");

          handler.next(e); // IMPORTANT: don't resolve for debugging


          String message = "Something went wrong";

          if (e.type == DioExceptionType.connectionError) {
            message = "Unable to connect to server";

          } else if (e.type == DioExceptionType.connectionTimeout) {
            message = "Connection timeout, try again later";
          } else if (e.type == DioExceptionType.receiveTimeout) {
            message = "Server response slow";
          } else if (e.response != null) {
            message = e.response?.data['message'] ?? "Server error";
          }

          Get.snackbar(
            "Error",
            message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade400,
            colorText: Colors.white,
          );

          handler.resolve(
            Response(
              requestOptions: e.requestOptions,
              statusCode: e.response?.statusCode ?? 500,
              data: {"error": true, "message": message},
            ),
          );
        },
      ),
    );
  }

  // ================= HTTP METHODS =================

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(
      url,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    String header = Headers.formUrlEncodedContentType ,
  }) async {
    final token = SharedPreferencesHelper().getString('accessToken');
    return await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(contentType: header,
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      cancelToken: cancelToken,
    );
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      cancelToken: cancelToken,
    );
  }
}

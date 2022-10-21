import 'package:dio/dio.dart';
import 'package:itai_test/services/network_service/base_response.dart';
import 'package:itai_test/services/network_service/debug_functions.dart';

class AppException implements Exception {
  static BaseResponse<T> handleError<T>(
    DioError e, {
    T? data,
  }) {
    debugLog(e);
    if (e.response != null && DioErrorType.response == e.type) {
      if (e.response!.statusCode! >= 500) {
        return const BaseResponse(
          status: false,
          error: "A server error occurred",
        );
      }
      if (e.response?.data is Map<String, dynamic>) {
        debugLog(BaseResponse.fromMap(e.response?.data).error);
        return BaseResponse.fromMap(e.response?.data);
      } else if (e.response?.data is String) {
        debugLog(e.response?.data);
        return BaseResponse(
          status: false,
          error: e.response?.data,
        );
      }
    }
    return BaseResponse(
      status: false,
      data: data,
      error: _mapException(e.type),
    );
  }

  static String _mapException(DioErrorType? error) {
    if (DioErrorType.connectTimeout == error ||
        DioErrorType.receiveTimeout == error ||
        DioErrorType.sendTimeout == error) {
      return "Your connection timed out";
    } else if (DioErrorType.other == error) {
      return 'Please check your internet connection';
    }
    return "An error occurred";
  }
}

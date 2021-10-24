import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(dioError?.response?.statusCode);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  ApiException.authError(String error) {
    switch (error) {
      case 'WRONG_PASSWORD':
        message = 'Неверный пароль';
        break;
      case 'USER_DOES_NOT_EXIST':
        message = 'Пользователя не существует';
        break;
      default:
        message = 'Ошибка авторизации. Повторите попытку позже';
        break;
    }
  }

  String message;

  String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

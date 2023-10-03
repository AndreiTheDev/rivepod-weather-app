import 'package:dio/dio.dart';

import 'error_types.dart';

class AppException implements Exception {
  AppException({required this.code, required this.message});

  final String code;
  final String message;

  factory AppException.getFirebaseException(final String code) {
    switch (code) {
      case emailExistsCode:
        return AppException(
          code: emailExistsCode,
          message: emailExistsMessage,
        );
      case internalErrorCode:
        return AppException(
          code: internalErrorCode,
          message: internalErrorMessage,
        );
      case invalidCredentialCode:
        return AppException(
          code: invalidCredentialCode,
          message: invalidCredentialMessage,
        );
      case invalidPasswordCode:
        return AppException(
          code: invalidPasswordCode,
          message: invalidPasswordMessage,
        );
      case userDisabledCode:
        return AppException(
          code: userDisabledCode,
          message: userDisabledMessage,
        );
      case userNotFoundCode:
        return AppException(
          code: userNotFoundCode,
          message: userNotFoundMessage,
        );
      case wrongPasswordCode:
        return AppException(
          code: wrongPasswordCode,
          message: wrongPasswordMessage,
        );
      case userCancelCode:
        return AppException(
          code: userCancelCode,
          message: userCancelCode,
        );
      case noUserDataCode:
        return AppException(
          code: noUserDataCode,
          message: noUserDataMessage,
        );
      case userNotExistsCode:
        return AppException(
          code: userNotExistsCode,
          message: userNotExistsMessage,
        );
      default:
        return AppException(
          code: unknownErrorCode,
          message: unknownErrorMessage,
        );
    }
  }

  factory AppException.getDioException(final DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return AppException(
          code: connectionTimeoutCode,
          message: connectionTimeoutMessage,
        );
      case DioExceptionType.sendTimeout:
        return AppException(code: sendTimeoutCode, message: sendTimeoutMessage);
      case DioExceptionType.receiveTimeout:
        return AppException(
          code: receiveTimeoutCode,
          message: receiveTimeoutMessage,
        );
      case DioExceptionType.badCertificate:
        return AppException(
          code: badCertificateCode,
          message: badCertificateMessage,
        );
      case DioExceptionType.badResponse:
        return AppException(code: badResponseCode, message: badResponseMessage);
      case DioExceptionType.cancel:
        return AppException(code: cancelCode, message: cancelMessage);
      case DioExceptionType.connectionError:
        return AppException(
          code: connectionErrorCode,
          message: connectionErrorMessage,
        );
      default:
        return AppException(
          code: unknownErrorCode,
          message: unknownErrorMessage,
        );
    }
    // return AppException(code: code, message: message)
  }
}

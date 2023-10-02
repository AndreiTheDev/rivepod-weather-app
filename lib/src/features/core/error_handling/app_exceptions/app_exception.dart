import 'package:dio/dio.dart';

import 'error_types.dart';

class AppException implements Exception {
  AppException({required this.code, required this.message});

  final String code;
  final String message;

  factory AppException.getFirebaseException(final String code) {
    switch (code) {
      case emailExists:
        return AppException(
          code: emailExists,
          message: emailExistsMessage,
        );
      case internalError:
        return AppException(
          code: internalError,
          message: internalErrorMessage,
        );
      case invalidCredential:
        return AppException(
          code: invalidCredential,
          message: invalidCredentialMessage,
        );
      case invalidPassword:
        return AppException(
          code: invalidPassword,
          message: invalidPasswordMessage,
        );
      case userDisabled:
        return AppException(
          code: userDisabled,
          message: userDisabledMessage,
        );
      case userNotFound:
        return AppException(
          code: userNotFound,
          message: userNotFoundMessage,
        );
      case wrongPassword:
        return AppException(
          code: wrongPassword,
          message: wrongPasswordMessage,
        );
      case userCancel:
        return AppException(
          code: userCancel,
          message: userCancel,
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

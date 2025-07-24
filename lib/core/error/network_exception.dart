// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_test/core/model/error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkException with _$NetworkException {
  const factory NetworkException.requestCancelled() = RequestCancelled;

  const factory NetworkException.unauthorizedRequest(String reason) = UnauthorizedRequest;

  const factory NetworkException.badRequest() = BadRequest;

  const factory NetworkException.notFound(String reason) = NotFound;

  const factory NetworkException.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkException.notAcceptable() = NotAcceptable;

  const factory NetworkException.requestTimeout() = RequestTimeout;

  const factory NetworkException.sendTimeout() = SendTimeout;

  const factory NetworkException.conflict() = Conflict;

  const factory NetworkException.internalServerError() = InternalServerError;

  const factory NetworkException.notImplemented() = NotImplemented;

  const factory NetworkException.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkException.noInternetConnection() = NoInternetConnection;

  const factory NetworkException.formatException() = FormatException;

  const factory NetworkException.unableToProcess() = UnableToProcess;

  const factory NetworkException.defaultError(String error) = DefaultError;

  const factory NetworkException.unexpectedError() = UnexpectedError;

  static NetworkException handleResponse(Response<dynamic>? response) {
    ErrorModel? errorModel;

    try {
      errorModel = ErrorModel.fromJson(response?.data as Map<String, dynamic>);
    } catch (_) {}

    final int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkException.unauthorizedRequest(
          errorModel?.errors?.first.detail ?? 'Not found',
        );
      case 404:
        return NetworkException.notFound(errorModel?.errors?.first.detail ?? 'Not found');
      case 409:
        return const NetworkException.conflict();
      case 408:
        return const NetworkException.requestTimeout();
      case 500:
        return const NetworkException.internalServerError();
      case 503:
        return const NetworkException.serviceUnavailable();
      default:
        final responseCode = statusCode;
        return NetworkException.defaultError('Received invalid status code: $responseCode');
    }
  }

  static NetworkException getDioException(dynamic error) {
    if (error is Exception) {
      try {
        NetworkException networkException;

        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkException = const NetworkException.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkException = const NetworkException.requestTimeout();
              break;
            case DioExceptionType.connectionError:
              networkException = const NetworkException.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.sendTimeout:
              networkException = const NetworkException.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkException = NetworkException.handleResponse(error.response);
              break;
            case DioExceptionType.unknown:
            case DioExceptionType.badCertificate:
              networkException = const NetworkException.unexpectedError();
              break;
          }
        } else if (error is SocketException) {
          networkException = const NetworkException.noInternetConnection();
        } else {
          networkException = const NetworkException.unexpectedError();
        }
        return networkException;
      } on FormatException catch (_) {
        return const NetworkException.formatException();
      } on Exception catch (_) {
        return const NetworkException.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkException.unableToProcess();
      } else {
        return const NetworkException.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkException networkException) => networkException.when(
    notImplemented: () => 'network_exception.not_implemented',
    requestCancelled: () => 'network_exception.request_cancelled',
    internalServerError: () => 'network_exception.internal_server_error',
    notFound: (reason) => 'network_exception.not_found',
    serviceUnavailable: () => 'network_exception.service_unavailable',
    methodNotAllowed: () => 'network_exception.method_not_allowed',
    badRequest: () => 'network_exception.bad_request',
    unauthorizedRequest: (error) => 'network_exception.unauthorized_request',
    unexpectedError: () => 'network_exception.unexpected_error',
    requestTimeout: () => 'network_exception.request_timeout',
    noInternetConnection: () => 'network_exception.no_internet_connection',
    conflict: () => 'network_exception.conflict',
    sendTimeout: () => 'network_exception.send_timeout',
    unableToProcess: () => 'network_exception.unable_to_process',
    defaultError: (error) => 'network_exception.default_error',
    formatException: () => 'network_exception.format_exception',
    notAcceptable: () => 'network_exception.not_acceptable',
  );
}

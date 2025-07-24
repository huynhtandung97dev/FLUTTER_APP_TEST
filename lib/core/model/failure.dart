import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_test/core/error/network_exception.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  NetworkFailure(this.exception);

  final NetworkException exception;

  @override
  List<Object?> get props => [exception];

  @override
  bool? get stringify => true;
}

class CacheFailure implements Exception {}

class LocalFailure extends Failure {
  LocalFailure(this.exception);

  final PlatformException exception;

  @override
  List<Object?> get props => [exception];

  @override
  bool? get stringify => true;
}

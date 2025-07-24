class RemoteServiceEnv {
  RemoteServiceEnv._();

  /// Dev environment URL
  static const _devServerUrl = 'assets/mock/';

  /// API URL
  static String get apiUrl => '$_devServerUrl/api/';

  /// Timeout in milliseconds
  static const dioTimeoutMS = 15000;
}

class RemoteTokensEnv {
  RemoteTokensEnv._();
}

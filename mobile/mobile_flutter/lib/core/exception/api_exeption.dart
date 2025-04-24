class ApiException implements Exception {
  final String errorCode;
  final String message;

  ApiException(this.errorCode, this.message);

  @override
  String toString() => '$errorCode: $message';

}
class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  // @override
  @override
  String toString() {
    return message;
  }
}

class httpException implements Exception {
  final message;
  httpException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}

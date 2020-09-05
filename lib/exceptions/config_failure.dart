class ConfigFailure implements Exception{
  @override
  String toString() {
    return "Failed to retrieve some important updates";
  }
}
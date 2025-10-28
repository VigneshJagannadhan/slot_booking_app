class NetworkHelper {
  static String handleNetworkErrMsg(String error) {
    if (error.toLowerCase().contains('connection refused') ||
        error.toLowerCase().contains('connection error') ||
        error.toLowerCase().contains('socketexception')) {
      return 'Unable to connect to server. Please check your internet connection and try again.';
    }
    if (error.toLowerCase().contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (error.toLowerCase().contains('no internet')) {
      return 'No internet connection. Please check your network settings.';
    }
    return error;
  }
}

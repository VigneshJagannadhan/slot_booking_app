import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.contains(ConnectivityResult.none)) return false;
      try {
        final lookup = await InternetAddress.lookup('google.com');
        return lookup.isNotEmpty;
      } catch (_) {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}

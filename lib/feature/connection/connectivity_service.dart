import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      print('Connectivity check error: $e');
      return false;
    }
  }

  Stream<bool> get onConnectivityChanged => _connectivity.onConnectivityChanged
          .map((event) => event != ConnectivityResult.none)
          .handleError((error) {
        print('Connectivity stream error: $error');
        return false;
      });
}

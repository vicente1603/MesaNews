import 'package:connectivity/connectivity.dart';

class InternetService {
  static Future<bool> verificarConexao() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    }
  }
}

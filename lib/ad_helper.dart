import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/6300978111"; //GOOgle's
      return "ca-app-pub-1890401635405164/3139740941"; //Mine
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}

import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2692120586756604~4600443300';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2692120586756604~3747005565';
    }
    return null;
  }

  String getBannerAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2692120586756604/1974279964';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2692120586756604/5913524979';
    }
    return null;
  }
}

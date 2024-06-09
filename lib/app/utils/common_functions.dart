import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Func{
  
  void dPrint(String s){
    if(kDebugMode) print(s);
  }

  
// Create storage\
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final iosOptions =
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  final storage = const FlutterSecureStorage();
  Future setString(String key, String value) async {
    await storage.write(
        key: key,
        value: value,
        aOptions: _getAndroidOptions(),
        iOptions: iosOptions);
  }

  Future<String> getString(String key) async {
    String? value = await storage.read(
            key: key, aOptions: _getAndroidOptions(), iOptions: iosOptions) ??
        '';
    return value;
  }

  void delString() {
    dPrint('Deleting whole data');
    storage.deleteAll();
  }
}


import 'package:flutter/foundation.dart';
import 'package:flutter_application_nilesh/app/constants/style.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Style.blackCol,
      textColor: Style.whiteCol,
      fontSize: 16.0,
    );
  }

  String returnDate(DateTime date){
    String formattedDate = DateFormat('d MMM yyyy').format(date);
    return formattedDate;
  }
}


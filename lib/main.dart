import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_nilesh/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //  GlobalBindings().dependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}

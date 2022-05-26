import 'package:calculos_unistamp/routes/appPages.dart';
import 'package:calculos_unistamp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Calculos - Unistamp",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      getPages: AppPages.routes,
    ),
  );
}

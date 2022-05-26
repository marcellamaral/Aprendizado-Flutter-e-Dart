import 'dart:async';

import 'package:calculos_unistamp/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    super.onInit();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    super.onReady();
    loading();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    super.onClose();
  }

  Future<void> loading() async {
    Timer(const Duration(seconds: 3), () => Get.offNamed(Routes.home));
  }
}

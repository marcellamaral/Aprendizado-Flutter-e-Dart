import 'package:calculos_unistamp/screens/controllers/splashController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  SplashScreen({Key? key}) : super(key: key);

  @override
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}

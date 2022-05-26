import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';

class CustomButton extends StatelessWidget {
  String route;
  String textCustomBT;

  CustomButton({Key? key, required this.textCustomBT, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
          minimumSize: Size(250, 40), backgroundColor: Colors.red.shade600),
      onPressed: () => Get.toNamed(route),
      child: Text(textCustomBT),
    );
  }
}

class CustomButtonCalcular extends StatelessWidget {
  Function() function;
  String textCustomBT;

  CustomButtonCalcular(
      {Key? key, required this.textCustomBT, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: ElevatedButton(
        style: TextButton.styleFrom(backgroundColor: Colors.red.shade600),
        onPressed: function,
        child: Text(textCustomBT),
      ),
    );
  }
}

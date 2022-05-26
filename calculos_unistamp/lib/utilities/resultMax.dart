import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultMax extends StatelessWidget {
  final RxString result;
  final String text;
  final String measure;

  ResultMax(
      {Key? key,
      required this.measure,
      required this.result,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.blue,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Obx(
              () => Text(
                "$result",
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            Text(measure),
          ],
        ),
      ),
    );
  }
}

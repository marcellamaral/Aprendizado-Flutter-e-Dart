import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuxInfo extends StatelessWidget {
  final RxString raioInterno;
  final RxString bordoMin;

  const AuxInfo({Key? key, required this.raioInterno, required this.bordoMin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.yellow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Raio Interno: "),
              Obx(
                () => Text(
                  "$raioInterno",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Bordo Minimo: "),
              Obx(
                () => Text(
                  "$bordoMin",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnaliseDeDados extends GetxController {
  late String _espessura;
  late String _comprimento;
  late String _canal;
  late String _material;
  late String _tonelagem;

  set espessura(esp) => _espessura = esp;
  set comprimento(com) => _comprimento = com;
  set canal(can) => _canal = can;
  set material(mat) => _material = mat;
  set tonelagem(ton) => _tonelagem = ton;

  final RxString _tonelagemMaxima = "0".obs;
  final RxString _espessuraMaxima = "0".obs;
  final RxString _comprimentoMaximo = "0".obs;
  final RxString _menorCanal = "0".obs;

  final RxString _raioInterno = "0".obs;
  final RxString _bordoMinimo = "0".obs;

  get tonelagemMaxima => _tonelagemMaxima;
  get espessuraMaxima => _espessuraMaxima;
  get comprimentoMaximo => _comprimentoMaximo;
  get menorCanal => _menorCanal;

  get raioInterno => _raioInterno;
  get bordoMinimo => _bordoMinimo;

  verificarCampos(String opcao) {
    switch (opcao) {
      case "ton":
        if (_espessura == "" ||
            _comprimento == "" ||
            _canal == "" ||
            _material == "") {
          aviso();
        } else {
          calcularTonelagem();
        }
        break;
      case "esp":
        if (_tonelagem == "" ||
            _comprimento == "" ||
            _canal == "" ||
            _material == "") {
          aviso();
        } else {
          calcularEspessura();
        }
        break;
      case "com":
        if (_espessura == "" ||
            _tonelagem == "" ||
            _canal == "" ||
            _material == "") {
          aviso();
        } else {
          calcularComprimento();
        }
        break;
      case "abe":
        if (_espessura == "" ||
            _comprimento == "" ||
            _tonelagem == "" ||
            _material == "") {
          aviso();
        } else {
          calcularAbertura();
        }
        break;
    }
  }

  void calcularTonelagem() {
    double espessura = double.parse(_espessura);
    double comprimento = double.parse(_comprimento);
    double canal = double.parse(_canal);
    double material = double.parse(_material);

    double calculo =
        (1.42 * comprimento * material * (pow(espessura, 2))) / canal;

    _tonelagemMaxima.value = calculo.toStringAsFixed(2);

    _raioInterno.value = (canal / 6.4).toStringAsFixed(2);
    _bordoMinimo.value = (canal * 0.7).toStringAsFixed(2);
  }

  void calcularEspessura() {
    double tonelagem = double.parse(_tonelagem);
    double comprimento = double.parse(_comprimento);
    double canal = double.parse(_canal);
    double material = double.parse(_material);

    double calculo =
        sqrt(((tonelagem * canal) / (1.42 * comprimento * material)));

    _espessuraMaxima.value = calculo.toStringAsFixed(2);
    _raioInterno.value = (canal / 6.4).toStringAsFixed(2);
    _bordoMinimo.value = (canal * 0.7).toStringAsFixed(2);
  }

  void calcularComprimento() {
    double tonelagem = double.parse(_tonelagem);
    double espessura = double.parse(_espessura);
    double canal = double.parse(_canal);
    double material = double.parse(_material);

    double calculo =
        (tonelagem * canal) / (1.42 * material * (pow(espessura, 2)));

    _comprimentoMaximo.value = calculo.toStringAsFixed(2);
    _raioInterno.value = (canal / 6.4).toStringAsFixed(2);
    _bordoMinimo.value = (canal * 0.7).toStringAsFixed(2);
  }

  void calcularAbertura() {
    double tonelagem = double.parse(_tonelagem);
    double espessura = double.parse(_espessura);
    double comprimento = double.parse(_comprimento);
    double material = double.parse(_material);

    double calculo =
        ((1.42 * comprimento * material * (pow(espessura, 2))) / tonelagem);

    _menorCanal.value = calculo.toStringAsFixed(2);
    _raioInterno.value = (tonelagem / 6.4).toStringAsFixed(2);
    _bordoMinimo.value = (tonelagem * 0.7).toStringAsFixed(2);
  }

  aviso() {
    Get.defaultDialog(
      title: "Aviso!",
      content: const Text("Por favor, preencher todos os campos."),
      contentPadding: const EdgeInsets.all(2),
      buttonColor: Colors.red.shade600,
      confirmTextColor: Colors.white,
      radius: 3,
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        style: TextButton.styleFrom(backgroundColor: Colors.red.shade600),
        child: const Text("Confirmar"),
      ),
    );
  }
}

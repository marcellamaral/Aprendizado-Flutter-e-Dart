import 'dart:math';
import 'package:flutter/material.dart';

int _valor = 0;
int? _escolha;
String icone = 'padrao.png';

String ganhouPerdeu() {
  if (_valor == 0 && _escolha == 1 ||
      _valor == 1 && _escolha == 2 ||
      _valor == 2 && _escolha == 0) {
    return 'O Jogador Venceu!';
  } else if (_valor == 0 && _escolha == 2 ||
      _valor == 1 && _escolha == 0 ||
      _valor == 2 && _escolha == 1) {
    return 'O Jogador Perdeu!';
  } else {
    return 'EMPATE!';
  }
}

void jogar(int opc) {
  _escolha = opc;
  List<String> escolhaDoPC = ['pedra.png', 'papel.png', 'tesoura.png'];

  _valor = Random().nextInt(3);
  icone = escolhaDoPC[_valor];
}

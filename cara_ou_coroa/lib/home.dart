// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cara_ou_coroa/jogo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void gerarMoeda() {
    List moedas = ['imagens/moeda_cara.png', 'imagens/moeda_coroa.png'];

    int valor = Random().nextInt(2);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaJogo(moedas[valor])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF61BD8C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('imagens/logo.png'),
          GestureDetector(
            onTap: () {
              gerarMoeda();
            },
            child: Image.asset('imagens/botao_jogar.png'),
          ),
        ],
      ),
    );
  }
}

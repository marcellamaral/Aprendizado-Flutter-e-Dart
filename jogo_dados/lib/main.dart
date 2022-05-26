// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  @override
  _MeuAppState createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  int numeroEsquerda = 1;
  int numeroDireita = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal.shade700,
        appBar: AppBar(
          title: Text('Dados'),
          backgroundColor: Colors.teal.shade900,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        numeroEsquerda = Random().nextInt(6) + 1;
                      });
                    },
                    child: Image.asset('imagens/dado$numeroEsquerda.png'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        numeroDireita = Random().nextInt(6) + 1;
                      });
                    },
                    child: Image.asset('imagens/dado$numeroDireita.png'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 175, 35, 11)),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(150)),
                    overlayColor: MaterialStateProperty.all(Colors.white38),
                  ),
                  onPressed: () {
                    setState(() {
                      numeroEsquerda = 1;
                      numeroDireita = 1;
                    });
                  },
                  child: Center(
                    child: Text(
                      'Resetar Dados',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 175, 35, 11)),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(150)),
                    overlayColor: MaterialStateProperty.all(Colors.white38),
                  ),
                  onPressed: () {
                    setState(() {
                      numeroDireita = Random().nextInt(6) + 1;
                      numeroEsquerda = Random().nextInt(6) + 1;
                    });
                  },
                  child: Center(
                    child: Text(
                      'Jogar Dados',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

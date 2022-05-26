// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  @override
  _MeuAppState createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  String valor = '0';

  void setarValor(String v) {
    setState(() {
      if (valor == '0') {
        valor = v;
      } else {
        valor += v;
      }
    });
  }

  void resetar() {
    setState(() {
      valor = '0';
    });
  }

  void realizarCalculo() {
    Parser p = Parser();
    Expression exp = p.parse(valor);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      valor = eval.toString();
    });
  }

  TextButton itens(funcao, String texto, Color cor) {
    return TextButton(
      onPressed: funcao,
      child: Text(
        texto,
        style: TextStyle(color: cor, fontSize: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: Text('Calculadora'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(15),
              width: 400,
              height: 120,
              child: Center(
                child: Text(
                  valor,
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      itens(() => resetar(), 'C', Colors.lightBlue),
                      itens(() => setarValor('('), '(', Colors.lightBlue),
                      itens(() => setarValor(')'), ')', Colors.lightBlue),
                      itens(() => setarValor('/'), '/', Colors.lightBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      itens(() => setarValor('7'), '7', Colors.white),
                      itens(() => setarValor('8'), '8', Colors.white),
                      itens(() => setarValor('9'), '9', Colors.white),
                      itens(() => setarValor('*'), '*', Colors.lightBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      itens(() => setarValor('4'), '4', Colors.white),
                      itens(() => setarValor('5'), '5', Colors.white),
                      itens(() => setarValor('6'), '6', Colors.white),
                      itens(() => setarValor('+'), '+', Colors.lightBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      itens(() => setarValor('1'), '1', Colors.white),
                      itens(() => setarValor('2'), '2', Colors.white),
                      itens(() => setarValor('3'), '3', Colors.white),
                      itens(() => setarValor('-'), '-', Colors.lightBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      itens(() => setarValor('0'), '0', Colors.white),
                      itens(() => setarValor('.'), '.', Colors.white),
                      itens(() => setarValor('%'), '%', Colors.lightBlue),
                      itens(() => realizarCalculo(), '=', Colors.lightBlue),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

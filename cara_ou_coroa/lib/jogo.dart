import 'package:flutter/material.dart';

class TelaJogo extends StatefulWidget {
  String valorAleatorio;

  TelaJogo(this.valorAleatorio);

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF61BD8C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(widget.valorAleatorio),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('imagens/botao_voltar.png'),
          ),
        ],
      ),
    );
  }
}

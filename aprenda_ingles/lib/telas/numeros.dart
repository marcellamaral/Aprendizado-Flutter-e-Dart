import 'package:flutter/material.dart';

import '../reproduzirSons.dart';

class Numeros extends StatefulWidget {
  const Numeros({Key? key}) : super(key: key);
  @override
  State<Numeros> createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
  ReproduzirSons som = ReproduzirSons();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      //scrollDirection: Axis.vertical,
      children: [
        GestureDetector(
          onTap: () => som.executarParar("1"),
          child: Image.asset("assets/imagens/1.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("2"),
          child: Image.asset("assets/imagens/2.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("3"),
          child: Image.asset("assets/imagens/3.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("4"),
          child: Image.asset("assets/imagens/4.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("5"),
          child: Image.asset("assets/imagens/5.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("6"),
          child: Image.asset("assets/imagens/6.png"),
        ),
      ],
    );
  }
}

import 'package:aprenda_ingles/reproduzirSons.dart';
import 'package:flutter/material.dart';

class Bixos extends StatefulWidget {
  const Bixos({Key? key}) : super(key: key);

  @override
  State<Bixos> createState() => _BixosState();
}

class _BixosState extends State<Bixos> {
  ReproduzirSons som = ReproduzirSons();

  @override
  Widget build(BuildContext context) {
    //double largura = MediaQuery.of(context).size.width;
    //double altura = MediaQuery.of(context).size.height;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      //scrollDirection: Axis.vertical,
      children: [
        GestureDetector(
          onTap: () => som.executarParar("cao"),
          child: Image.asset("assets/imagens/cao.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("gato"),
          child: Image.asset("assets/imagens/gato.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("leao"),
          child: Image.asset("assets/imagens/leao.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("macaco"),
          child: Image.asset("assets/imagens/macaco.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("ovelha"),
          child: Image.asset("assets/imagens/ovelha.png"),
        ),
        GestureDetector(
          onTap: () => som.executarParar("vaca"),
          child: Image.asset("assets/imagens/vaca.png"),
        ),
      ],
    );
  }
}

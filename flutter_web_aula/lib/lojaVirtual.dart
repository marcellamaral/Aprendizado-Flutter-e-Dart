import 'package:flutter/material.dart';
import 'package:flutter_web_aula/widget/itemProduto.dart';
import 'package:flutter_web_aula/widget/mobileAppBar.dart';
import 'package:flutter_web_aula/widget/webAppBar.dart';

class LojaVirtual extends StatefulWidget {
  const LojaVirtual({Key? key}) : super(key: key);

  @override
  State<LojaVirtual> createState() => _LojaVirtualState();
}

class _LojaVirtualState extends State<LojaVirtual> {
  _ajustarVisualizacao(double largura) {
    if (largura <= 600) {
      return 2;
    } else if (largura <= 960) {
      return 4;
    } else {
      return 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        var largura = constraints.maxWidth;
        var altura = AppBar().preferredSize.height;

        return Scaffold(
          appBar: largura < 600
              ? PreferredSize(
                  child: const MobileAppBar(),
                  preferredSize: Size(largura, altura),
                )
              : PreferredSize(
                  child: const WebAppBar(),
                  preferredSize: Size(largura, altura),
                ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: _ajustarVisualizacao(largura),
              children: const [
                ItemProduto(
                    imagem: "p1.jpg", valor: "250,00", desc: "Televisão"),
                ItemProduto(imagem: "p2.jpg", valor: "250,00", desc: "Pneu"),
                ItemProduto(
                    imagem: "p3.jpg", valor: "250,00", desc: "Galaxy S9"),
                ItemProduto(
                    imagem: "p4.jpg", valor: "250,00", desc: "Galaxy Edge"),
                ItemProduto(
                    imagem: "p5.jpg", valor: "50,00", desc: "Galaxy Phone"),
                ItemProduto(
                    imagem: "p6.jpg", valor: "250,00", desc: "Iphone XR"),
              ],
            ),
          ),
        );
      }),
    );
  }
}

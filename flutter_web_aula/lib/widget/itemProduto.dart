import 'package:flutter/material.dart';

class ItemProduto extends StatelessWidget {
  final String imagem;
  final String valor;
  final String desc;

  const ItemProduto({
    Key? key,
    required this.imagem,
    required this.valor,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "imagens/$imagem",
            fit: BoxFit.contain,
          ),
          Text("$desc"),
          Text("R\$$valor"),
        ],
      ),
    );
  }
}

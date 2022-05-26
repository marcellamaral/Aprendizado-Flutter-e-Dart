import 'package:flutter/material.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
      children: [
        Image.asset("imagens/logo.png"),
        Expanded(child: Container()),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart_rounded),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("Cadastrar"),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("Entrar"),
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
        ),
      ],
    ));
  }
}

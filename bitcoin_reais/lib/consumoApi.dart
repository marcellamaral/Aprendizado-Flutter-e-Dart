import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Aplicativo extends StatefulWidget {
  @override
  State<Aplicativo> createState() => _AplicativoState();
}

class _AplicativoState extends State<Aplicativo> {
  Future<Map> recuperarPreco() async {
    var url = Uri.parse("https://blockchain.info/ticker");
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: recuperarPreco(),
      builder: (context, snapshot) {
        String resultado;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            print("conexao waiting");
            resultado = "Carregando...";
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            print("conexao done");
            if (snapshot.hasError) {
              resultado = "Erro ao carregar os dados.";
            } else {
              dynamic valor = snapshot.data!["BRL"]["buy"];
              resultado = "${valor.toString()}";
            }
            break;
        }

        return Center(
          child: Text(
            resultado,
            style: TextStyle(fontSize: 25),
          ),
        );
      },
    );
  }
}

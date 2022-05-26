// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'consumoApi.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*String _valorBitcoin = '';

  _obterValorBitcoin() async {
    var url = Uri.parse("https://blockchain.info/ticker");

    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _valorBitcoin = "R\$ ${retorno['BRL']['buy'].toString()}";
    });
  }*/

  Widget? opc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/bitcoin.png'),
            Padding(
              padding: EdgeInsets.only(top: 35, bottom: 35),
              child: opc,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  opc = Aplicativo();
                });
              },
              child: Text('Atualizar'),
              style: ElevatedButton.styleFrom(primary: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

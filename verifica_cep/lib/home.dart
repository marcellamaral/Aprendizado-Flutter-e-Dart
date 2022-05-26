// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _cep = TextEditingController();

  String cidade = '';
  String uf = '';
  String bairro = '';

  _recuperarCep(cep) async {
    var url = Uri.parse("https://viacep.com.br/ws/$cep/json/");

    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      cidade = retorno['localidade'];
      uf = retorno['uf'];
      bairro = retorno['bairro'] == '' ? 'Não Possui' : retorno['bairro'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumo de Serviços'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Digite seu CEP'),
              maxLength: 8,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: _cep,
            ),
            Center(
              child: TextButton(
                onPressed: () => _recuperarCep(_cep.text),
                child: Text(
                  'Enviar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
              ),
            ),
            Text('UF: $uf'),
            Text('Cidade: $cidade'),
            Text('Bairro: $bairro'),
          ],
        ),
      ),
    );
  }
}

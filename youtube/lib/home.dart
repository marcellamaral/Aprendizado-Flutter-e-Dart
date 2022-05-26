// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:youtube/pesquisar.dart';
import 'package:youtube/telas/biblioteca.dart';
import 'package:youtube/telas/emAlta.dart';
import 'package:youtube/telas/inicio.dart';
import 'package:youtube/telas/inscricoes.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Text("a"),
      Inscricoes(),
      Biblioteca(),
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 25),
        backgroundColor: Color(0xFF282828),
        title: Image.asset(
          "images/youtubenovo.jpg",
          width: 100,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.cast),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () async {
              String res =
                  await showSearch(context: context, delegate: Pesquisar());
              setState(() {
                _resultado = res;
              });
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: telas[indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceAtual,
        type: BottomNavigationBarType.fixed,
        onTap: (indice) {
          setState(() {
            indiceAtual = indice;
          });
        },
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        iconSize: 20,
        fixedColor: Colors.red,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.black,
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.orange,
            label: 'Shorts',
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.yellow,
            label: "",
            icon: Icon(
              Icons.add_circle_outline,
              size: 37,
            ),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.blue,
            label: 'Subscriptions',
            icon: Icon(Icons.subscriptions),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.green,
            label: 'Library',
            icon: Icon(Icons.video_library),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'perguntas.dart';

Perguntas perguntas = Perguntas();

void main() {
  runApp(HarryPotterHouses());
}

class HarryPotterHouses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: HarryPotterPage(),
        ));
  }
}

class HarryPotterPage extends StatefulWidget {
  @override
  _HarryPotterPageState createState() => _HarryPotterPageState();
}

class _HarryPotterPageState extends State<HarryPotterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/harrypotter.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 12,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Text(
                    perguntas.obterPergunta(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    perguntas.nextQuestion(1);
                  });
                },
                child: Text(
                  perguntas.obterresposta1(1),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              flex: 2,
              child: Visibility(
                visible: perguntas.visible(),
                child: TextButton(
                  onPressed: () {
                    setState(
                      () {
                        perguntas.nextQuestion(2);
                      },
                    );
                  },
                  child: Text(
                    perguntas.obterresposta2(2),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

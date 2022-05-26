// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'sistema.dart';

class Principal extends StatefulWidget {
  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JokenPo'),
        backgroundColor: Color.fromARGB(202, 255, 230, 5),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text('Escolha do App:'),
          ),
          Image.asset(
            'images/$icone',
            height: 120,
          ),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(ganhouPerdeu()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      jogar(0);
                    },
                  );
                },
                child: Image.asset(
                  'images/pedra.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      jogar(1);
                    },
                  );
                },
                child: Image.asset(
                  'images/papel.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      jogar(2);
                    },
                  );
                },
                child: Image.asset(
                  'images/tesoura.png',
                  height: 90,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

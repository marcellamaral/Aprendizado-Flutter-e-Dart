// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 7, 110, 161),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('img/ma.jpg'),
              ),
              Text(
                'Marcell Amaral',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico'),
              ),
              Text(
                'DESENVOLVEDOR FLUTTER',
                style: TextStyle(
                    fontFamily: 'Source',
                    color: Color.fromARGB(255, 186, 209, 231),
                    fontSize: 20,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
                width: 250,
                child: Divider(
                  color: Color.fromARGB(255, 186, 209, 231),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 7, 110, 161),
                    size: 25,
                  ),
                  title: Text(
                    '+55 11 97127-4177',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 7, 110, 161),
                        fontFamily: 'Source'),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.email,
                      size: 25, color: Color.fromARGB(255, 7, 110, 161)),
                  title: Text(
                    'marcell_amaral@hotmail.com',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 7, 110, 161),
                        fontFamily: 'Source'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

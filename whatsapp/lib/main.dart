import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/cadastro.dart';
import 'package:whatsapp/configuracoes.dart';
import 'package:whatsapp/login.dart';

import 'home.dart';

import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/cadastro': (context) => const Cadastro(),
        '/home': (context) => Home(),
        '/login': (context) => const Login(),
        '/configuracoes': (context) => const Configuracoes(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:uber/telas/cadastro.dart';
import 'package:uber/telas/corrida.dart';
import 'package:uber/telas/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uber/telas/painelMotorista.dart';
import 'package:uber/telas/painelPassageiro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: "Uber",
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Home(),
        '/cadastro': (context) => const Cadastro(),
        '/painelMotorista': (context) => const PainelMotorista(),
        '/painelPassageiro': (context) => const PainelPassageiro(),
      },
    ),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/model/usuario.dart';

import 'cadastro.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        Usuario user = Usuario();
        user.email = email;
        user.senha = senha;
        _logarUsuario(user);
      } else {
        setState(() {
          _mensagemErro =
              "Erro! senha não preenchida ou com menos de 7 caracteres...";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Erro! e-mail não preenchido ou inválido...";
      });
    }
  }

  _logarUsuario(Usuario usuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((value) async {
      String id = value.user!.uid;
      _redirecionaPainelTipoUsuario(id);
    }).catchError((erro) {
      setState(() {
        _mensagemErro =
            "Erro ao autenticar o usuário, verifique e-mail e senha digitada!";
      });
    });
  }

  _redirecionaPainelTipoUsuario(String id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios").doc(id).get();
    String tipoUsuario = snapshot["tipoUsuario"];

    tipoUsuario == "motorista"
        ? Navigator.pushNamedAndRemoveUntil(
            context, "/painelMotorista", (route) => false)
        : Navigator.pushNamedAndRemoveUntil(
            context, "/painelPassageiro", (route) => false);
  }

  _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userLogado = auth.currentUser;

    if (userLogado != null) {
      String id = auth.currentUser!.uid;
      _redirecionaPainelTipoUsuario(id);
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/fundo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "imagens/logo.png",
                  width: 200,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: TextField(
                    controller: _controllerEmail,
                    enabled: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Digite seu e-mail...",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 10),
                  child: TextField(
                    controller: _controllerSenha,
                    obscureText: true,
                    enabled: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "Digite sua senha...",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _validarCampos();
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(13),
                      backgroundColor: const Color.fromARGB(255, 38, 99, 122),
                      elevation: 10),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cadastro(),
                    ),
                  ),
                  child: const Text(
                    "Não tem conta? Cadastre-se!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(_mensagemErro),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

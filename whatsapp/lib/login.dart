import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  _validarCampos() {
    if (_controllerEmail.text.isEmpty || _controllerSenha.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Preencha todos os campos!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (!_controllerEmail.text.contains("@")) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Insira um e-mail válido!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      _fazerLogin();
    }
  }

  _fazerLogin() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Usuário logado com sucesso!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (route) => false),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }).catchError((erro) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Erro ao logar.  ${erro.code}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }

  _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userAtual = auth.currentUser;
    if (userAtual != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      });
    }
  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF075E54),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      /*border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),*/
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.lightGreen),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.lightGreen),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: _controllerSenha,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _validarCampos();
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: const Text("Não tem conta? Cadastre-se!"),
                    onTap: () {
                      Navigator.pushNamed(context, "/cadastro");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

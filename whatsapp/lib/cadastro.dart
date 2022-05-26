import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/model/usuario.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
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
    } else if (!email.contains("@")) {
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
      Usuario user = Usuario();
      user.setNome = nome;
      user.setEmail = email;
      user.setSenha = senha;
      _cadastrarUsuario(user);
    }
  }

  _salvarDadosUsuario(String uid, Map<String, dynamic> map) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("usuarios").doc(uid).set(map);
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then(
      (value) {
        _salvarDadosUsuario(value.user!.uid, usuario.toMap());
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Usuário criado com sucesso!"),
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
      },
    ).catchError((erro) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Erro na criação da conta.  ${erro.code}"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: const Color(0xFF075E54),
      ),
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
                    "imagens/usuario.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
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
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _validarCampos();
                    },
                    child: const Text(
                      "Cadastrar",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

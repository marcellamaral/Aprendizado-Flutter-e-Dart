import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/model/usuario.dart';
import 'package:uber/telas/home.dart';
import 'package:uber/telas/painelMotorista.dart';
import 'package:uber/telas/painelPassageiro.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool _bSwitch = false;
  String _mensagemErro = "";
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();

  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6) {
          _cadastrarUsuario();
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
    } else {
      setState(() {
        _mensagemErro = "Erro! Insira um nome...";
      });
    }
  }

  _cadastrarUsuario() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    Usuario user = Usuario();
    user.nome = nome;
    user.email = email;
    user.verificarUsuario(_bSwitch);

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      setState(() {
        _mensagemErro = "Usuario criado com sucesso!";
      });
      db.collection("usuarios").doc(value.user!.uid).set(user.toMap());

      user.tipoUsuario == "passageiro"
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PainelPassageiro(),
              ),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PainelMotorista(),
              ),
              (route) => false);
    }).catchError((erro) {
      setState(() {
        _mensagemErro =
            "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Color.fromARGB(255, 58, 74, 79),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _controllerNome,
                  enabled: true,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "nome",
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
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _controllerEmail,
                  enabled: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "e-mail",
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
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  obscureText: true,
                  controller: _controllerSenha,
                  enabled: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "senha",
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
              Row(
                children: [
                  Text("Passageiro"),
                  Switch(
                    activeColor: Colors.black,
                    value: _bSwitch,
                    onChanged: (bool value) {
                      setState(() {
                        _bSwitch = value;
                      });
                    },
                  ),
                  Text("Motorista"),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _validarCampos();
                },
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(13),
                    backgroundColor: const Color.fromARGB(255, 38, 99, 122),
                    elevation: 10),
              ),
              Text(_mensagemErro),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  const Configuracoes({Key? key}) : super(key: key);

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

enum opcao { galeria, camera }

class _ConfiguracoesState extends State<Configuracoes> {
  final TextEditingController _controllerNome = TextEditingController();
  String? _imagem;
  bool _subindoImagem = false;

  Future _obterimagem(var opc) async {
    XFile? imagem;
    switch (opc) {
      case opcao.galeria:
        imagem = await ImagePicker().pickImage(source: ImageSource.gallery);
        break;
      case opcao.camera:
        imagem = await ImagePicker().pickImage(source: ImageSource.camera);
        break;
    }

    if (imagem != null) {
      _uploadImagem(imagem.path);
    }
  }

  Future _uploadImagem(String imagem) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;

    Reference pastaRaiz = FirebaseStorage.instance.ref();
    Reference arquivo = pastaRaiz.child("perfil").child("$uid.jpg");

    UploadTask task = arquivo.putFile(File(imagem));

    task.snapshotEvents.listen((TaskSnapshot event) {
      if (event.state == TaskState.running) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (event.state == TaskState.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    task.whenComplete(() => null).then((value) {
      _recuperarUrlImagem(value);
    });
  }

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    setState(() {
      _imagem = url;
    });
  }

  Future _salvarDadosUsuario() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    String nome = _controllerNome.text;

    db
        .collection("usuarios")
        .doc(uid)
        .update({"urlPerfil": _imagem, "nome": nome});
  }

  _recuperarDadosUsuario() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;

    DocumentSnapshot snapshot = await db.collection("usuarios").doc(uid).get();

    setState(() {
      _controllerNome.text = snapshot.get("nome");
      _imagem = snapshot.get("urlPerfil");
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Text("Configurações"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: _subindoImagem
                      ? const Center(child: CircularProgressIndicator())
                      : CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(_imagem.toString()),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _obterimagem(opcao.camera);
                      },
                      child: const Text(
                        "Câmera",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _obterimagem(opcao.galeria);
                      },
                      child: const Text(
                        "Galeria",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                TextField(
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
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _salvarDadosUsuario();
                    },
                    child: const Text(
                      "Salvar",
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

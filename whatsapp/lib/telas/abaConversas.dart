import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:whatsapp/model/usuario.dart';

import '../mensagens.dart';

class AbaConversas extends StatefulWidget {
  const AbaConversas({Key? key}) : super(key: key);

  @override
  State<AbaConversas> createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _adicionarListenerConversas() {
    final stream = db
        .collection("conversas")
        .doc(auth.currentUser!.uid)
        .collection("ultima_conversa")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerConversas();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    var _stream = StreamBuilder(
        stream: _controller.stream,
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              QuerySnapshot querySnapshot = snapshot.data;

              if (snapshot.hasError) {
                return const Text("Erro ao carregar as mensagens");
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, indice) {
                      //Recupera Mensagens:
                      List<QueryDocumentSnapshot> mensagens =
                          querySnapshot.docs.toList();

                      QueryDocumentSnapshot item = mensagens[indice];

                      Usuario usuario = Usuario();

                      usuario.idUsuario = item["idDestinatario"];
                      usuario.setNome = item["nome"];
                      usuario.setUrl = item["caminhoFoto"];

                      return ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Mensagens(usuario))),
                        title: Text(item["nome"]),
                        subtitle: item["tipoMensagem"] == "texto"
                            ? Text(item["mensagem"])
                            : const Text("Imagem"),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: item["caminhoFoto"] == null
                              ? null
                              : NetworkImage(item["caminhoFoto"]),
                        ),
                      );
                    },
                    itemCount: querySnapshot.docs.length,
                  ),
                );
              }
          }
        });

    return _stream;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/mensagens.dart';
import 'package:whatsapp/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbaContatos extends StatefulWidget {
  const AbaContatos({Key? key}) : super(key: key);

  @override
  State<AbaContatos> createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  String? _idUsuarioLogado;
  String? _emailUsuarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await db.collection("usuarios").get();
    List<Usuario> listaUsuarios = [];

    for (DocumentSnapshot itens in snapshot.docs) {
      if (_emailUsuarioLogado == itens.get("email")) continue;
      Usuario usuario = Usuario();
      usuario.idUsuario = itens.id;
      usuario.setEmail = itens.get("email");
      usuario.setNome = itens.get("nome");
      usuario.setUrl = itens.get("urlPerfil");

      listaUsuarios.add(usuario);
    }

    return listaUsuarios;
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    _idUsuarioLogado = auth.currentUser!.uid;
    _emailUsuarioLogado = auth.currentUser!.email;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
        future: _recuperarContatos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  //backgroundColor: Colors.green,
                  color: Colors.green,
                ),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Erro ao carregar!"),
                );
              } else {
                return ListView.separated(
                  itemBuilder: (context, indice) {
                    Usuario usuario = snapshot.data![indice];
                    String nome = snapshot.data![indice].nome;
                    String url = snapshot.data![indice].url;

                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Mensagens(usuario))),
                      title: Text(nome),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: url != null ? NetworkImage(url) : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, indice) => const Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
          }
        });
  }
}

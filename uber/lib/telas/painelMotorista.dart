import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/telas/corrida.dart';
import 'package:uber/util/statusRequisicao.dart';
import 'package:uber/util/usuarioFirebase.dart';

class PainelMotorista extends StatefulWidget {
  const PainelMotorista({Key? key}) : super(key: key);

  @override
  State<PainelMotorista> createState() => _PainelMotoristaState();
}

class _PainelMotoristaState extends State<PainelMotorista> {
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _listenerConversa() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final stream = db
        .collection("requisicoes")
        .where("status", isEqualTo: StatusRequisicao.aguardando)
        .snapshots();

    stream.listen(
      (event) {
        _controller.add(event);
      },
    );
  }

  List<String> itensMenu = [
    "Configurações",
    "Deslogar",
  ];

  _escolhaMenu(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Deslogar":
        _deslogarUsuario();
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }

  _verificarSeEstaEmCorrida() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String idMotorista = UsuarioFirebase.getUsuarioAtual();

    DocumentSnapshot<Map> dados = await db
        .collection("requisicao_ativa_motorista")
        .doc(idMotorista)
        .get();

    var dadosRequisicao = dados.data();

    if (dadosRequisicao != null) {
      String idRequisicao = dadosRequisicao["idRequisicao"];
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Corrida(idRequisicao)));
    } else {
      _listenerConversa();
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarSeEstaEmCorrida();
  }

  @override
  void dispose() {
    super.dispose();

    _listenerConversa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Motorista"),
        backgroundColor: Color.fromARGB(255, 58, 74, 79),
        actions: [
          PopupMenuButton(
            onSelected: _escolhaMenu,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: ((context, AsyncSnapshot snapshot) {
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
                return const Text("Erro ao carregar as mensgens");
              } else {
                if (querySnapshot.docs.isEmpty) {
                  return const Center(
                    child: Text("Você não tem nenhuma requisição =("),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: querySnapshot.docs.length,
                    itemBuilder: (context, index) {
                      List solicitacoes = querySnapshot.docs;
                      String idRequisicao = solicitacoes[index]["id"];
                      String nome = solicitacoes[index]["passageiro"]["nome"];

                      String endereco =
                          solicitacoes[index]["destino"]["bairro"];
                      endereco += "\n" + solicitacoes[index]["destino"]["rua"];
                      endereco +=
                          ", " + solicitacoes[index]["destino"]["numero"];

                      return ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Corrida(idRequisicao))),
                        title: Text(nome),
                        subtitle: Text(endereco),
                      );
                    },
                  );
                }
              }
          }
        }),
      ),
    );
  }
}

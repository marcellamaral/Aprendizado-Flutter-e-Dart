import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'mapa.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  _abrirMapa(LatLng local) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Mapa(localizacao: local),
      ),
    );
  }

  _excluirViagem(String id) {
    db.collection("locais").doc(id).delete();
  }

  _adicionarLocal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Mapa(),
      ),
    );
  }

  final _controller = StreamController<QuerySnapshot>.broadcast();

  _listenerViagens() {
    final stream = db.collection("locais").snapshots();

    stream.listen((event) {
      _controller.add(event);
    });
  }

  @override
  void initState() {
    super.initState();
    _listenerViagens();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Localizações"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _adicionarLocal(),
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff0066cc),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
              QuerySnapshot? querysnapshot = snapshot.data;

              if (snapshot.hasError) {
                return Text("Erro ao carregar as viagens");
              } else {
                return ListView.builder(
                  itemCount: querysnapshot!.docs.length,
                  itemBuilder: (context, indice) {
                    List<QueryDocumentSnapshot> viagens =
                        querysnapshot.docs.toList();

                    QueryDocumentSnapshot itens = viagens[indice];
                    String id = itens.id;
                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          title: Text(itens["endereco"]),
                          trailing: GestureDetector(
                            onTap: () => _excluirViagem(id),
                            child: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => _abrirMapa(
                          LatLng(itens["latitude"], itens["longitude"])),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}

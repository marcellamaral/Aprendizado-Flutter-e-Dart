// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../api.dart';
import '../model/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  String pesquisa;
  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _pesquisa(String texto) {
    Api api = Api();
    return api.pesquisar(texto);
  }

  @override
  Widget build(BuildContext context) {
    Api api = Api();
    return Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List<Video>>(
        future: _pesquisa(widget.pesquisa),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao Carregar"),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, indice) => Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, indice) {
                    Video lista = snapshot.data![indice];

                    return GestureDetector(
                      onTap: () {
                        FlutterYoutube.playYoutubeVideoById(
                          apiKey: chaveYoutubeAPI,
                          videoId: lista.id,
                          autoPlay: true,
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Image.network(lista.imagem),
                          ),
                          ListTile(
                            title: Text(lista.titulo),
                            subtitle: Text(lista.canal),
                          ),
                        ],
                      ),
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

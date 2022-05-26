// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Pesquisar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      close(context, query);
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> lista = [];

    if (query.isNotEmpty) {
      lista = ["Android", "Android navegação", "IOS", "Jogos"]
          .where((texto) => texto.toLowerCase().startsWith(query.toLowerCase()))
          .toList();

      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                close(context, lista[index]);
              },
              title: Text(lista[index]),
            );
          });
    } else {
      return Center(
        child: Text("Nenhum resultado para a pesquisa!"),
      );
    }
  }
}

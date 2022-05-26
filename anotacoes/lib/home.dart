import 'package:anotacoes/helper/bancoDados.dart';
import 'package:anotacoes/module/tarefas.dart';
import 'package:anotacoes/screen/tarefa.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BancoDados bd = BancoDados();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Anotações"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => inserirModificarTarefas(context),
        ),
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: FutureBuilder<List<Tarefas>>(
        future: bd.recuperarTarefa(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('ERRO ao carregar.'),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, indice) => Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, indice) {
                    var tarefa = snapshot.data![indice];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            tarefa.titulo.toString(),
                          ),
                          subtitle: Text(tarefa.id.toString()),
                        ),
                        Text(tarefa.descricao.toString())
                      ],
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

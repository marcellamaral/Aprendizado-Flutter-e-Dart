// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/helper/anotacaoHelper.dart';
import 'package:minhas_anotacoes/model/anotacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  var _db = AnotacaoHelper();

  _exibirTelaCadastro() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Adiconar Anotação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Título",
                  hintText: "Digite título...",
                ),
              ),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  hintText: "Digite descrição...",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                _salvarAnotacao();
                Navigator.pop(context);
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  _salvarAnotacao() {
    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    Anotacao anotacao = Anotacao(titulo, descricao, DateTime.now().toString());
    _db.salvarAnotacao(anotacao);
    _listarTarefas();
  }

  List<Map<String, dynamic>> tarefas = [];

  _listarTarefas() async {
    tarefas.clear();
    AnotacaoHelper helper = AnotacaoHelper();
    List<Map<String, dynamic>> tarefa = await helper.pegarTarefas();

    for (var i in tarefa) {
      setState(() {
        tarefas.add(i);
      });
    }
    print(tarefas);
  }

  _formatarData(String data) {
    initializeDateFormatting('pt_BR');

    /* Year = y, Month = M, Day = d
       Hour = H, Minute = m, Second = s
     */

    //var formatador = DateFormat("d/M/y");
    var formatador = DateFormat.yMEd("pt_BR");

    DateTime dataConvertida = DateTime.parse(data);

    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }

  @override
  void initState() {
    _listarTarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Anotações"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          _descricaoController.text = "";
          _tituloController.text = "";
          _exibirTelaCadastro();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          int id = tarefas[index]["id"];

          return Dismissible(
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            direction: DismissDirection.horizontal,
            background: Container(
              padding: EdgeInsets.all(16),
              color: Colors.green,
              child: Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.all(16),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                Anotacao itemDeletado = Anotacao(
                  tarefas[index]["titulo"],
                  tarefas[index]["descricao"],
                  tarefas[index]["data"],
                );
                //Remover
                AnotacaoHelper helper = AnotacaoHelper();
                helper.excluirTarefa(tarefas[index]["id"]);
                _listarTarefas();

                final snackBar = SnackBar(
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                      label: "Desfazer",
                      onPressed: () {
                        AnotacaoHelper helper = AnotacaoHelper();
                        helper.salvarAnotacao(itemDeletado);
                        _listarTarefas();
                      }),
                  content: Text("Tarefa Removida"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (direction == DismissDirection.startToEnd) {
                _descricaoController.text = tarefas[index]["descricao"];
                _tituloController.text = tarefas[index]["titulo"];

                //modificar
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Editar Tarefa"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Titulo",
                              //hintText: titulo,
                            ),
                            controller: _tituloController,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Descrição",
                              //hintText: descricao,
                            ),
                            controller: _descricaoController,
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            AnotacaoHelper helper = AnotacaoHelper();
                            helper.atualizarTarefa(
                              _tituloController.text,
                              _descricaoController.text,
                              id,
                            );
                            _listarTarefas();
                            Navigator.pop(context);
                          },
                          child: Text("Salvar"),
                        ),
                      ],
                    );
                  },
                );
                _listarTarefas();
              }
            },
            child: ListTile(
              title: Text(tarefas[index]["titulo"]),
              subtitle: Row(
                children: [
                  Text(
                    _formatarData(
                      tarefas[index]['data'],
                    ),
                  ),
                  Text(" - "),
                  Text(
                    tarefas[index]["descricao"],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

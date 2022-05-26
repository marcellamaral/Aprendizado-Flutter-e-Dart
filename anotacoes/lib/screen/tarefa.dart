import 'package:anotacoes/helper/bancoDados.dart';
import 'package:flutter/material.dart';

TextEditingController _tituloController = TextEditingController();
TextEditingController _descricaoController = TextEditingController();

inserirModificarTarefas(context) {
  return AlertDialog(
    title: const Text("Inserir Tarefa"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
              labelText: "Título", hintText: "Digite o título..."),
          controller: _tituloController,
        ),
        TextField(
          decoration: const InputDecoration(
              labelText: "Descrição", hintText: "Digite a descrição..."),
          controller: _descricaoController,
        )
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancelar"),
      ),
      TextButton(
        onPressed: () {
          BancoDados bd = BancoDados();
          bd.salvarTarefa(
            _tituloController.text,
            _descricaoController.text,
            DateTime.now().toString(),
          );
          _tituloController.clear();
          _descricaoController.clear();
          Navigator.pop(context);
        },
        child: const Text("Salvar"),
      )
    ],
  );
}

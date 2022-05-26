import 'dart:async';

import 'package:anotacoes/module/tarefas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  static final BancoDados _singleton = BancoDados._internal();

  factory BancoDados() {
    return _singleton;
  }

  BancoDados._internal();

  String nomeTabela = "tarefas";

  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        String sql =
            "CREATE TABLE $nomeTabela (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo VARCHAR, descricao TEXT, data DATETIME)";

        db.execute(sql);
      },
    );

    return bd;
  }

  salvarTarefa(String titulo, String descricao, String data) async {
    Database db = await _recuperarBancoDados();

    Map<String, dynamic> tarefa = {
      "titulo": titulo,
      "descricao": descricao,
      "data": data,
    };

    await db.insert(nomeTabela, tarefa);
  }

  Future<List<Tarefas>> recuperarTarefa() async {
    Database db = await _recuperarBancoDados();

    String sql = "SELECT * FROM $nomeTabela";

    List tarefa = await db.rawQuery(sql);

    List<Tarefas> tarefas = [];

    for (var itens in tarefa) {
      Tarefas t = Tarefas(itens["titulo"], itens["descricao"], itens["data"],
          itens["id"].toString());
      tarefas.add(t);
    }

    return tarefas;
  }
}

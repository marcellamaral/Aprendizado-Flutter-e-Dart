import 'package:minhas_anotacoes/model/anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {
  static const String nomeTabela = "anotacao";
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database? _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal();

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    /*

    id titulo descricao data
    01 teste  teste     02/10/2020

    * */

    String sql = "CREATE TABLE $nomeTabela ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "titulo VARCHAR, "
        "descricao TEXT, "
        "data DATETIME)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados =
        join(caminhoBancoDados, "banco_minhas_anotacoes.db");

    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    Database bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, anotacao.toMap());
    return resultado;
  }

  pegarTarefas() async {
    Database bancoDados = await db;

    String sql = "SELECT * FROM $nomeTabela";

    List tarefas = await bancoDados.rawQuery(sql);

    List<Map<String, dynamic>> lista = [];
    for (Map<String, dynamic> tarefa in tarefas) {
      lista.add(tarefa);
    }

    return lista;
  }

  excluirTarefa(int id) async {
    Database bancoDados = await db;

    bancoDados.delete(nomeTabela, where: "id=?", whereArgs: [id]);
  }

  atualizarTarefa(String titulo, String descricao, int id) async {
    Database bancoDados = await db;

    Map<String, dynamic> dados = {"titulo": titulo, "descricao": descricao};

    await bancoDados.update(nomeTabela, dados, where: "id=?", whereArgs: [id]);
  }
}

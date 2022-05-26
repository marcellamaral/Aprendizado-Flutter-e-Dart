import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa {
  String? _idRemetente;
  String? _idDestinatario;
  String? _nome;
  String? _mensagem;
  String? _caminhoFoto;
  String? _tipoMensagem; //Texto ou Imagem

  get nome => _nome;
  get mensagem => _mensagem;
  get caminhoFoto => _caminhoFoto;
  get idRemetente => _idRemetente;
  get idDestinatario => _idDestinatario;
  get tipoMensagem => _tipoMensagem;

  set nome(nome) => _nome = nome;
  set mensagem(mensagem) => _mensagem = mensagem;
  set caminhoFoto(caminhoFoto) => _caminhoFoto = caminhoFoto;
  set idRemetente(idRemetente) => _idRemetente = idRemetente;
  set idDestinatario(idDestinatario) => _idDestinatario = idDestinatario;
  set tipoMensagem(tipoMensagem) => _tipoMensagem = tipoMensagem;

  salvar() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db
        .collection("conversas")
        .doc(_idRemetente)
        .collection("ultima_conversa")
        .doc(_idDestinatario)
        .set(toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idRemetente": _idRemetente,
      "idDestinatario": _idDestinatario,
      "nome": _nome,
      "mensagem": _mensagem,
      "caminhoFoto": _caminhoFoto,
      "tipoMensagem": _tipoMensagem,
    };
    return map;
  }
}

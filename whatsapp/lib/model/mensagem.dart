class Mensagem {
  String? _idUsuario;
  String? _mensagem;
  String? _urlImagem;

  //Define o tipo da mensagem, se será um texto ou uma imagem.
  String? _tipo;

  DateTime? _time;

  set idUsuario(id) => _idUsuario = id;
  set mensagem(msg) => _mensagem = msg;
  set urlImagem(url) => _urlImagem = url;
  set tipo(tipo) => _tipo = tipo;
  set time(tm) => _time = tm;

  get idUsuario => _idUsuario;
  get mensagem => _mensagem;
  get urlImagem => _urlImagem;
  get tipo => _tipo;
  get time => _time;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": _idUsuario,
      "mensagem": _mensagem,
      "urlImagem": _urlImagem,
      "tipo": _tipo,
      "time": _time,
    };
    return map;
  }
}

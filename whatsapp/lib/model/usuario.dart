class Usuario {
  String? _nome;
  String? _email;
  String? _senha;
  String? _urlPerfil;
  String? _idUsuario;

  get nome => _nome;
  get email => _email;
  get senha => _senha;
  get url => _urlPerfil;
  get idUsuario => _idUsuario;

  set setNome(nome) => _nome = nome;
  set setUrl(url) => _urlPerfil = url;
  set setEmail(email) => _email = email;
  set setSenha(senha) => _senha = senha;
  set idUsuario(id) => _idUsuario = id;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": _nome,
      "email": _email,
      "urlPerfil": _urlPerfil
    };
    return map;
  }
}

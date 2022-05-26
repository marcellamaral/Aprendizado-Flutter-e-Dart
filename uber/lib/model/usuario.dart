import 'dart:ffi';

class Usuario {
  String? _idUsuario;
  String? _nome;
  String? _email;
  String? _senha;
  String? _tipoUsuario;

  double? _latitude;
  double? _longitude;

  get idUsuario => _idUsuario;
  get nome => _nome;
  get email => _email;
  get senha => _senha;
  get tipoUsuario => _tipoUsuario;
  get latitude => _latitude;
  get longitude => _longitude;

  set idUsuario(id) => _idUsuario = id;
  set nome(nome) => _nome = nome;
  set email(email) => _email = email;
  set senha(senha) => _senha = senha;
  set tipoUsuario(tipo) => _tipoUsuario = tipo;
  set latitude(latitude) => _latitude = latitude;
  set longitude(longitude) => _longitude = longitude;

  verificarUsuario(bool tipo) {
    tipo ? _tipoUsuario = "motorista" : _tipoUsuario = "passageiro";
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = {
      "nome": _nome,
      "email": _email,
      "tipoUsuario": _tipoUsuario,
      "latitude": _latitude,
      "longitude": _longitude,
    };

    return mapa;
  }
}

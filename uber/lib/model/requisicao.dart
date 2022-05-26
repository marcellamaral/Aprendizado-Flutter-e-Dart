import 'package:uber/model/destino.dart';
import 'package:uber/model/usuario.dart';

class Requisicao {
  String? _id;
  String? _status;
  Usuario? _passageiro;
  Usuario? _motorista;
  Destino? _destino;

  get id => _id;
  get status => _status;
  get passageiro => _passageiro;
  get motorista => _motorista;
  get destino => _destino;

  set id(id) => _id = id;
  set status(status) => _status = status;
  set passageiro(passageiro) => _passageiro = passageiro;
  set motorista(motorista) => _motorista = motorista;
  set destino(destino) => _destino = destino;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> dadosPassageiro = {
      "nome": _passageiro!.nome,
      "email": _passageiro!.email,
      "tipoUsuario": _passageiro!.tipoUsuario,
      "idUsuario": _passageiro!.idUsuario,
      "latitude": _passageiro!.latitude,
      "longitude": _passageiro!.longitude,
    };

    Map<String, dynamic> dadosDestino = {
      "rua": _destino!.rua,
      "numero": _destino!.numero,
      "bairro": _destino!.bairro,
      "cep": _destino!.cep,
      "latitude": _destino!.latitude,
      "longitude": _destino!.longitude,
    };

    Map<String, dynamic> dadosRequisicao = {
      "status": _status,
      "passageiro": dadosPassageiro,
      "motorista": null,
      "destino": dadosDestino,
    };
    return dadosRequisicao;
  }
}

class Destino {
  String? _rua;
  String? _numero;
  String? _cidade;
  String? _bairro;
  String? _cep;
  double? _latitude;
  double? _longitude;

  get rua => _rua;
  get numero => _numero;
  get cidade => _cidade;
  get bairro => _bairro;
  get cep => _cep;
  get latitude => _latitude;
  get longitude => _longitude;

  set rua(rua) => _rua = rua;
  set numero(numero) => _numero = numero;
  set cidade(cidade) => _cidade = cidade;
  set bairro(bairro) => _bairro = bairro;
  set cep(cep) => _cep = cep;
  set latitude(latitude) => _latitude = latitude;
  set longitude(longitude) => _longitude = longitude;
}

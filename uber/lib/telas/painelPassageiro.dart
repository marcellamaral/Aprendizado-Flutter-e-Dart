import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uber/model/destino.dart';
import 'package:uber/model/requisicao.dart';
import 'package:uber/util/statusRequisicao.dart';
import 'package:uber/util/usuarioFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/usuario.dart';

class PainelPassageiro extends StatefulWidget {
  const PainelPassageiro({Key? key}) : super(key: key);

  @override
  State<PainelPassageiro> createState() => _PainelPassageiroState();
}

class _PainelPassageiroState extends State<PainelPassageiro> {
  Position? _localPassageiro;
  final Set<Marker> _marcadores = {};
  final TextEditingController _controllerDestino =
      TextEditingController(text: "Av. Paulista, 807");

  List<String> itensMenu = [
    "Configurações",
    "Deslogar",
  ];

  //Controles para exibição na tela
  bool _exibirCaixaEnderecoDestino = true;
  String _textoBotao = "Chamar Uber";
  Color _corBotao = Color.fromARGB(255, 38, 99, 122);
  Function()? _funcaoBotao;

  _escolhaMenu(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Deslogar":
        _deslogarUsuario();
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }

  final Completer<GoogleMapController> _controller = Completer();
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  CameraPosition _posicaoCamera = const CameraPosition(
    target: LatLng(-23.13036312941631, -46.737352423300315),
    zoom: 16,
  );

  _recuperarUltimaLocalizacao() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      _posicaoCamera = CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 16,
      );
      _localPassageiro = position;
      _exibirMarcadorPassageiro(position);
      _movimentarCamera();
    }
  }

  _listenerLocalizacao() {
    LocationSettings _locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(locationSettings: _locationSettings)
        .listen((position) {
      _posicaoCamera = CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 16,
      );
      _localPassageiro = position;
      _exibirMarcadorPassageiro(position);
      _movimentarCamera();
    });
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_posicaoCamera),
    );
  }

  _exibirMarcadorPassageiro(Position local) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            "imagens/passageiro.png")
        .then((value) {
      Marker marcadorPassageiro = Marker(
          markerId: MarkerId("marcador-passageiro"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: "Meu local"),
          icon: value);

      setState(() {
        _marcadores.add(marcadorPassageiro);
      });
    });
  }

  _chamarUber() async {
    String destino = _controllerDestino.text;

    if (destino.isNotEmpty) {
      List<Location> listaEnderecos = await locationFromAddress(destino);

      if (listaEnderecos.isNotEmpty) {
        Location item = listaEnderecos[0];

        List<Placemark> placeMark =
            await placemarkFromCoordinates(item.latitude, item.longitude);

        Placemark endereco = placeMark[0];

        Destino destino = Destino();
        destino.cidade = endereco.administrativeArea;
        destino.cep = endereco.postalCode;
        destino.bairro = endereco.subLocality;
        destino.rua = endereco.thoroughfare;
        destino.numero = endereco.subThoroughfare;

        destino.latitude = item.latitude;
        destino.longitude = item.longitude;

        String enderecoConfirmacao;

        enderecoConfirmacao = "\n Cidade: " + destino.cidade;
        enderecoConfirmacao += "\n Rua: " + destino.rua + ", " + destino.numero;
        enderecoConfirmacao += "\n Bairro: " + destino.bairro;
        enderecoConfirmacao += "\n Cep: " + destino.cep;

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Confirmação do endereço"),
                content: Text(enderecoConfirmacao),
                contentPadding: EdgeInsets.all(16),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Salvar requisição
                      _salvarRequisicao(destino);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              );
            });
      }
    }
  }

  _salvarRequisicao(Destino destino) async {
    Usuario passageiro = await UsuarioFirebase.recuperarUsuario();
    passageiro.latitude = _localPassageiro!.latitude;
    passageiro.longitude = _localPassageiro!.longitude;

    Requisicao requisicao = Requisicao();
    requisicao.destino = destino;
    requisicao.passageiro = passageiro;
    requisicao.status = StatusRequisicao.aguardando;

    FirebaseFirestore db = FirebaseFirestore.instance;

    //Salvar requisição
    db.collection("requisicoes").add(requisicao.toMap()).then((value) {
      requisicao.id = value.id;
      db
          .collection("requisicoes")
          .doc(requisicao.id)
          .update({"id": requisicao.id});

      //Salvar requisição ativa
      Map<String, dynamic> dadosRequisicaoAtiva = {};

      dadosRequisicaoAtiva["id_requisicao"] = requisicao.id;
      dadosRequisicaoAtiva["id_usuario"] = passageiro.idUsuario;
      dadosRequisicaoAtiva["status"] = StatusRequisicao.aguardando;

      db
          .collection("requisicao_ativa")
          .doc(passageiro.idUsuario)
          .set(dadosRequisicaoAtiva);
    });
  }

  _alterarBotaoPrincipal(String texto, Color cor, Function() funcao) {
    setState(() {
      _textoBotao = texto;
      _corBotao = cor;
      _funcaoBotao = funcao;
    });
  }

  _statusUberNaoChamado() {
    _exibirCaixaEnderecoDestino = true;
    _alterarBotaoPrincipal(
      "Chamar Uber",
      Color.fromARGB(255, 38, 99, 122),
      () => _chamarUber(),
    );
  }

  _statusAguardando() {
    _exibirCaixaEnderecoDestino = false;
    _alterarBotaoPrincipal(
      "Cancelar",
      Colors.red,
      () => _cancelarUber(),
    );
  }

  _statusACaminho() {
    _exibirCaixaEnderecoDestino = false;
    _alterarBotaoPrincipal(
      "Motorista a caminho caminho",
      Colors.grey,
      () {},
    );

    double latitudePassageiro = _localPassageiro!.latitude;
    double latitudeLongitude = _localPassageiro!.longitude;
  }

  _cancelarUber() async {
    String firebaseUser = UsuarioFirebase.getUsuarioAtual();
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot<Map> req =
        await db.collection("requisicao_ativa").doc(firebaseUser).get();

    String idRequisicao = req["id_requisicao"];

    db.collection("requisicoes").doc(idRequisicao).update(
      {"status": StatusRequisicao.cancelada},
    ).then((value) {
      db.collection("requisicao_ativa").doc(firebaseUser).delete();
    });
  }

  _listenerRequisicaoAtiva() {
    String firebaseUser = UsuarioFirebase.getUsuarioAtual();
    FirebaseFirestore db = FirebaseFirestore.instance;

    db.collection("requisicao_ativa").doc(firebaseUser).snapshots().listen(
      (event) {
        if (event.data() == null) {
          _statusUberNaoChamado();
        } else {
          Map<String, dynamic>? item = event.data();
          String status = item!["status"];
          switch (status) {
            case StatusRequisicao.aguardando:
              _statusAguardando();
              break;
            case StatusRequisicao.aCaminho:
              _statusACaminho();
              break;
            case StatusRequisicao.viagem:
              break;
            case StatusRequisicao.finalizada:
              _statusUberNaoChamado();
              break;
            case StatusRequisicao.cancelada:
              _statusUberNaoChamado();
              break;
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _recuperarUltimaLocalizacao();
    _listenerLocalizacao();

    _listenerRequisicaoAtiva();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Passageiro"),
        backgroundColor: Color.fromARGB(255, 58, 74, 79),
        actions: [
          PopupMenuButton(
            onSelected: _escolhaMenu,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: _posicaoCamera,
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            markers: _marcadores,
          ),
          Visibility(
            visible: _exibirCaixaEnderecoDestino,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                      ),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 15),
                            width: 10,
                            height: 10,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                          ),
                          hintText: "Meu Local",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _controllerDestino,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 15),
                            width: 10,
                            height: 10,
                            child: const Icon(
                              Icons.local_taxi,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Digite o destino",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _funcaoBotao,
                child: Text(
                  _textoBotao,
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(13),
                    backgroundColor: _corBotao,
                    elevation: 10),
              ),
            ),
          )
        ],
      ),
    );
  }
}

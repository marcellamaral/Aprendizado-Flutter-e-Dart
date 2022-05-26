import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/model/usuario.dart';
import 'package:uber/util/statusRequisicao.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uber/util/usuarioFirebase.dart';

class Corrida extends StatefulWidget {
  String idRequisicao;

  Corrida(this.idRequisicao);

  @override
  State<Corrida> createState() => _CorridaState();
}

class _CorridaState extends State<Corrida> {
  String _mensagemStatus = "";
  Set<Marker> _marcadores = {};
  Map<String, dynamic>? _dadosRequisicao;
  Position? _localMotorista;

  //Controles para exibição na tela
  String _textoBotao = "Aceitar corrida";
  Color _corBotao = Color.fromARGB(255, 38, 99, 122);
  Function()? _funcaoBotao;

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
      //Atualizar localização em tempo real do motorista
    }
  }

  _listenerLocalizacao() {
    LocationSettings _locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(locationSettings: _locationSettings)
        .listen((position) {
      //_movimentarCamera();
      setState(() {
        _localMotorista = position;
      });
    });
  }

  _movimentarCamera(CameraPosition camera) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(camera),
    );
  }

  _exibirMarcadorMotorista(Position local) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            "imagens/motorista.png")
        .then((value) {
      Marker marcadorPassageiro = Marker(
          markerId: MarkerId("marcador-motorista"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: "Meu local"),
          icon: value);

      setState(() {
        _marcadores.add(marcadorPassageiro);
      });
    });
  }

  _alterarBotaoPrincipal(String texto, Color cor, Function() funcao) {
    setState(() {
      _textoBotao = texto;
      _corBotao = cor;
      _funcaoBotao = funcao;
    });
  }

  _recuperarRequisicao() async {
    String idRequisicao = widget.idRequisicao;

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await db.collection("requisicoes").doc(idRequisicao).get();
  }

  _listenerRequisicao() async {
    String idRequisicao = widget.idRequisicao;

    FirebaseFirestore db = FirebaseFirestore.instance;

    await db
        .collection("requisicoes")
        .doc(idRequisicao)
        .snapshots()
        .listen((event) {
      if (event.data() != null) {
        setState(() {
          _dadosRequisicao = event.data();
        });

        Map<String, dynamic>? dados = event.data();
        String status = dados!["status"];

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
            //_statusUberNaoChamado();
            break;
          case StatusRequisicao.cancelada:
            //_statusUberNaoChamado();
            break;
        }
      }
    });
  }

  _statusAguardando() {
    _alterarBotaoPrincipal(
      "Aceitar Corrida",
      Color.fromARGB(255, 38, 99, 122),
      () => _aceitarCorrida(),
    );

    double motoristaLat = _localMotorista!.latitude;
    double motoristaLon = _localMotorista!.longitude;

    Position position = Position(
        longitude: motoristaLon,
        latitude: motoristaLat,
        timestamp: null,
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);

    CameraPosition camera = CameraPosition(
      target: LatLng(
        position.latitude,
        position.longitude,
      ),
      zoom: 16,
    );

    _exibirMarcadorMotorista(position);
    _movimentarCamera(camera);
  }

  _statusACaminho() {
    _mensagemStatus = "A caminho do passageiro";
    _alterarBotaoPrincipal(
      "Iniciar Corrida",
      Color.fromARGB(255, 38, 99, 122),
      () => _iniciarCorrida(),
    );

    double latitudePassageiro = _dadosRequisicao!["passageiro"]["latitude"];
    double longitudePassageiro = _dadosRequisicao!["passageiro"]["longitude"];
    double latitudeMotorista = _dadosRequisicao!["motorista"]["latitude"];
    double longitudeMotorista = _dadosRequisicao!["motorista"]["longitude"];

    print("Motorista" +
        latitudeMotorista.toString() +
        longitudeMotorista.toString());
    print("Passageiro" +
        latitudePassageiro.toString() +
        longitudePassageiro.toString());

    _exibirDoisMarcadores(
      LatLng(latitudePassageiro, longitudePassageiro),
      LatLng(latitudeMotorista, longitudeMotorista),
    );

    var nLat, nLon, sLat, sLon;

    if (latitudeMotorista <= latitudePassageiro) {
      sLat = latitudeMotorista;
      nLat = latitudePassageiro;
    } else {
      sLat = latitudePassageiro;
      nLat = latitudeMotorista;
    }

    if (longitudeMotorista <= longitudePassageiro) {
      sLon = longitudeMotorista;
      nLon = longitudePassageiro;
    } else {
      sLon = longitudePassageiro;
      nLon = longitudeMotorista;
    }

    LatLngBounds latLngBounds = LatLngBounds(
        southwest: LatLng(sLat, sLon), northeast: LatLng(nLat, nLon));

    _movimentarCameraBounds(latLngBounds);
  }

  _iniciarCorrida() {}

  _movimentarCameraBounds(LatLngBounds latLngBounds) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(latLngBounds, 100),
    );
  }

  _exibirDoisMarcadores(LatLng passageiro, LatLng motorista) {
    Set<Marker> _listaMarcadores = {};

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            "imagens/motorista.png")
        .then((value) {
      Marker marcadorMotorista = Marker(
          markerId: MarkerId("marcador-motorista"),
          position: LatLng(motorista.latitude, motorista.longitude),
          infoWindow: InfoWindow(title: "Local do Motorista"),
          icon: value);

      _listaMarcadores.add(marcadorMotorista);
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            "imagens/passageiro.png")
        .then((value) {
      Marker marcadorPassageiro = Marker(
          markerId: MarkerId("marcador-passageiro"),
          position: LatLng(passageiro.latitude, passageiro.longitude),
          infoWindow: InfoWindow(title: "Local do Passageiro"),
          icon: value);

      _listaMarcadores.add(marcadorPassageiro);
    });

    setState(() {
      _marcadores = _listaMarcadores;
    });
  }

  _aceitarCorrida() async {
    String idRequisicao = widget.idRequisicao;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Usuario motorista = await UsuarioFirebase.recuperarUsuario();

    motorista.latitude = _localMotorista!.latitude;
    motorista.longitude = _localMotorista!.longitude;

    await db.collection("requisicoes").doc(idRequisicao).update({
      "status": StatusRequisicao.aCaminho,
      "motorista": motorista.toMap(),
    }).then((_) {
      //Atualiza requisição ativa
      String idPassageiro = _dadosRequisicao!["passageiro"]["idUsuario"];
      db.collection("requisicao_ativa").doc(idPassageiro).update({
        "status": StatusRequisicao.aCaminho,
      });

      //Salvar requisição ativa para motorista
      String idMotorista = motorista.idUsuario;

      db.collection("requisicao_ativa_motorista").doc(idMotorista).set({
        "motorista": motorista.toMap(),
        "status": StatusRequisicao.aCaminho,
        "idRequisicao": idRequisicao,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _listenerRequisicao();
    _recuperarUltimaLocalizacao();
    _listenerLocalizacao();

    //Adicionar listener para mudanças na requisição

    //_recuperarRequisicao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Corrida - " + _mensagemStatus),
        backgroundColor: Color.fromARGB(255, 58, 74, 79),
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

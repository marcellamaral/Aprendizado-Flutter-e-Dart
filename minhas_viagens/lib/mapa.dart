import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mapa extends StatefulWidget {
  var _localizacao;

  Mapa({
    Key? key,
    var localizacao,
  }) : super(key: key) {
    _localizacao = localizacao;
  }

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  CameraPosition _posicaoCamera = const CameraPosition(
    target: LatLng(-23.13036312941631, -46.737352423300315),
    zoom: 16,
  );

  final Completer<GoogleMapController> _controller = Completer();
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _marcadores = {};
  _exibirMarcador(LatLng latLng) async {
    List<Placemark> listaEnderecos =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    String nomeMarcador = "Marcador-${latLng.latitude}-${latLng.longitude}";
    String? endereco = listaEnderecos[0].thoroughfare;

    Marker marcador = Marker(
      markerId: MarkerId(nomeMarcador),
      position: latLng,
      infoWindow: InfoWindow(title: "$endereco"),
    );

    setState(() {
      _marcadores.add(marcador);
    });

    db.collection("locais").doc(nomeMarcador).set({
      "endereco": endereco,
      "latitude": latLng.latitude,
      "longitude": latLng.longitude,
    });
  }

  _recuperarMarcadores() async {
    QuerySnapshot snapshot = await db.collection("locais").get();
    List<QueryDocumentSnapshot> lista = snapshot.docs.toList();

    for (var itens in snapshot.docs) {
      String id = itens.id;
      Marker marcador = Marker(
        markerId: MarkerId(id),
        position: LatLng(
          itens["latitude"],
          itens["longitude"],
        ),
        infoWindow: InfoWindow(title: itens["endereco"]),
      );
      setState(() {
        _marcadores.add(marcador);
      });
    }
  }

  _listenerLocalizacao() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    LocationSettings _locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );

    if (widget._localizacao == null) {
      Geolocator.getPositionStream(locationSettings: _locationSettings).listen(
        (event) {
          _posicaoCamera = CameraPosition(
            target: LatLng(event.latitude, event.longitude),
            zoom: 18,
          );
          _movimentarCamera();
        },
      );
    } else {
      _posicaoCamera = CameraPosition(target: widget._localizacao, zoom: 18);
      _movimentarCamera();
    }
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_posicaoCamera),
    );
  }

  @override
  void initState() {
    super.initState();
    _listenerLocalizacao();
    _recuperarMarcadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa"),
      ),
      body: GoogleMap(
        initialCameraPosition: _posicaoCamera,
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        onLongPress: _exibirMarcador,
        markers: _marcadores,
        myLocationEnabled: true,
      ),
    );
  }
}

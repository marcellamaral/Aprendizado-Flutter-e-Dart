import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/mensagem.dart';
import 'package:whatsapp/model/usuario.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'model/conversa.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;

  Mensagens(this.contato);

  @override
  State<Mensagens> createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _idUsuarioLogado = "";
  String _idUsuarioDestinatario = "";
  String _nomeUsuarioLogado = "";
  String _urlUsuarioLogado = "";
  String _urlUsuarioDestinatario = "";

  bool _subindoImagem = false;

  TextEditingController _controllerMensagem = TextEditingController();

  _enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;

    if (textoMensagem.isNotEmpty) {
      Mensagem mensagem = Mensagem();
      mensagem.idUsuario = _idUsuarioLogado;
      mensagem.mensagem = textoMensagem;
      mensagem.urlImagem = "";
      mensagem.tipo = "texto";
      mensagem.time = DateTime.now();

      //Salvar para o remetente
      _salvarMensagem(_idUsuarioLogado, _idUsuarioDestinatario, mensagem);
      //Salvar para o destinatario
      _salvarMensagem(_idUsuarioDestinatario, _idUsuarioLogado, mensagem);

      //Salvar Conversa
      _salvarConversa(mensagem);
    }
  }

  _salvarConversa(Mensagem msg) {
    //Salvar conversa remetente
    Conversa cRemetente = Conversa();
    cRemetente.idRemetente = _idUsuarioLogado;
    cRemetente.idDestinatario = _idUsuarioDestinatario;
    cRemetente.mensagem = msg.mensagem;
    cRemetente.nome = widget.contato.nome;
    cRemetente.caminhoFoto = _urlUsuarioDestinatario;
    cRemetente.tipoMensagem = msg.tipo;
    cRemetente.salvar();

    //Salvar conversa destinatario
    Conversa cDestinatario = Conversa();
    cDestinatario.idRemetente = _idUsuarioDestinatario;
    cDestinatario.idDestinatario = _idUsuarioLogado;
    cDestinatario.mensagem = msg.mensagem;
    cDestinatario.nome = _nomeUsuarioLogado;
    cDestinatario.caminhoFoto = _urlUsuarioLogado;
    cDestinatario.tipoMensagem = msg.tipo;
    cDestinatario.salvar();
  }

  _salvarMensagem(
      String idRemetente, String idDestinatario, Mensagem msg) async {
    await db
        .collection("mensagens")
        .doc(idRemetente)
        .collection(idDestinatario)
        .add(msg.toMap());

    _controllerMensagem.clear();
  }

  Future _enviarFoto() async {
    String? _imagem;
    XFile? imagem;
    imagem = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      _imagem = imagem.path;
    }

    String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();

    Reference pastaRaiz = FirebaseStorage.instance.ref();
    Reference arquivo = pastaRaiz
        .child("mensagens")
        .child(_idUsuarioLogado)
        .child("$nomeImagem.jpg");

    UploadTask task = arquivo.putFile(File(_imagem.toString()));

    task.snapshotEvents.listen((TaskSnapshot event) {
      if (event.state == TaskState.running) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (event.state == TaskState.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    task.whenComplete(() => null).then((value) {
      _recuperarUrlImagem(value);
    });
  }

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    Mensagem mensagem = Mensagem();
    mensagem.idUsuario = _idUsuarioLogado;
    mensagem.mensagem = "";
    mensagem.urlImagem = url;
    mensagem.tipo = "imagem";
    mensagem.time = DateTime.now();

    //Salvar para o remetente
    _salvarMensagem(_idUsuarioLogado, _idUsuarioDestinatario, mensagem);
    //Salvar para o destinatario
    _salvarMensagem(_idUsuarioDestinatario, _idUsuarioLogado, mensagem);

    //Salvar Conversa
    _salvarConversa(mensagem);
  }

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    DocumentSnapshot snapshot1 =
        await db.collection("usuarios").doc(auth.currentUser!.uid).get();
    DocumentSnapshot snapshot2 =
        await db.collection("usuarios").doc(widget.contato.idUsuario).get();

    setState(() {
      _idUsuarioLogado = auth.currentUser!.uid;
      _idUsuarioDestinatario = widget.contato.idUsuario;
      _nomeUsuarioLogado = snapshot1.get("nome").toString();
      _urlUsuarioLogado = snapshot1.get("urlPerfil").toString();
      _urlUsuarioDestinatario = snapshot2.get("urlPerfil");
    });
    _adicionarListenerConversas();
  }

  final _controller = StreamController<QuerySnapshot>.broadcast();
  ScrollController _scrollController = ScrollController();

  _adicionarListenerConversas() {
    final stream = db
        .collection("mensagens")
        .doc(_idUsuarioLogado)
        .collection(_idUsuarioDestinatario)
        .orderBy("time", descending: false)
        .snapshots();

    stream.listen((event) {
      _controller.add(event);
      Timer(const Duration(milliseconds: 30), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _recuperarDadosUsuario();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    final _caixaMensagens = Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMensagem,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  prefixIcon: _subindoImagem
                      ? const CircularProgressIndicator()
                      : IconButton(
                          onPressed: () => _enviarFoto(),
                          icon: const Icon(Icons.camera_alt),
                        ),
                  contentPadding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                  hintText: "Digite uma mensagem...",
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () => _enviarMensagem(),
            backgroundColor: const Color(0xFF075E54),
            child: const Icon(Icons.send),
            mini: true,
          )
        ],
      ),
    );

    var _stream = StreamBuilder(
        stream: _controller.stream,
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              QuerySnapshot querySnapshot = snapshot.data;

              if (snapshot.hasError) {
                return const Text("Erro ao carregar as mensagens");
              } else {
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, indice) {
                      //Recupera Mensagens:
                      List<QueryDocumentSnapshot> mensagens =
                          querySnapshot.docs.toList();

                      QueryDocumentSnapshot item = mensagens[indice];

                      //Define cores e alinhamentos:
                      Alignment alinhamento = Alignment.centerRight;
                      Color cor = const Color(0xffd2ffa5);
                      EdgeInsets padding =
                          const EdgeInsets.fromLTRB(32, 8, 8, 8);

                      //double larguraContainer = MediaQuery.of(context).size.width;

                      if (item["idUsuario"] != _idUsuarioLogado) {
                        alinhamento = Alignment.centerLeft;
                        cor = Colors.white;
                        padding = const EdgeInsets.fromLTRB(8, 8, 32, 8);
                      }

                      return Align(
                        alignment: alinhamento,
                        child: Padding(
                          padding: padding,
                          child: Container(
                            //width: larguraContainer * 0.8,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: cor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: item["tipo"] == "texto"
                                ? Text(item["mensagem"])
                                : Image.network(item["urlImagem"]),
                          ),
                        ),
                      );
                    },
                    itemCount: querySnapshot.docs.length,
                  ),
                );
              }
          }
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget.contato.url != null
                  ? NetworkImage(widget.contato.url)
                  : null,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.contato.nome),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("imagens/bg.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_stream, _caixaMensagens],
          ),
        )),
      ),
    );
  }
}

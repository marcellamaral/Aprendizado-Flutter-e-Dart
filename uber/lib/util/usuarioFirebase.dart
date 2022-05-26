import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/usuario.dart';

class UsuarioFirebase {
  static String getUsuarioAtual() {
    FirebaseAuth auth = FirebaseAuth.instance;

    return auth.currentUser!.uid;
  }

  static Future<Usuario> recuperarUsuario() async {
    String idUsuario = getUsuarioAtual();

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map> infoUserLogado =
        await db.collection("usuarios").doc(idUsuario).get();

    Usuario usuario = Usuario();
    usuario.email = infoUserLogado["email"];
    usuario.nome = infoUserLogado["nome"];
    usuario.tipoUsuario = infoUserLogado["tipoUsuario"];
    usuario.idUsuario = idUsuario;

    return usuario;
  }
}

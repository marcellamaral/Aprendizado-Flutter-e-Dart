import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/telas/abaContatos.dart';
import 'package:whatsapp/telas/abaConversas.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<String> itensMenu = ["Configurações", "Deslogar"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _verificarUsuarioLogado();
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Deslogar":
        _deslogarUsuario();
        break;
      case "Configurações":
        Navigator.pushNamed(context, "/configuracoes");
        print(itemEscolhido);
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    //Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    //});
  }

  _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userAtual = auth.currentUser;
    if (userAtual == null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        automaticallyImplyLeading: false,
        title: const Text("WhatsApp"),
        bottom: TabBar(
          indicatorWeight: 2,
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Conversas",
            ),
            Tab(
              text: "Contatos",
            )
          ],
        ),
        actions: [
          PopupMenuButton(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [AbaConversas(), AbaContatos()],
      ),
    );
  }
}

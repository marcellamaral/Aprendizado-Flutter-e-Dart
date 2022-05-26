import 'package:aprenda_ingles/telas/bixos.dart';
import 'package:aprenda_ingles/telas/numeros.dart';
import 'package:aprenda_ingles/telas/vogais.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff795548),
        title: const Text("Aprenda Inglês"),
        bottom: TabBar(
          indicatorWeight: 3,
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: "Bixos"),
            Tab(text: "Numeros"),
            Tab(text: "Vogais"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Bixos(),
          Numeros(),
          Vogais(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ResponsividadeRowCol extends StatefulWidget {
  const ResponsividadeRowCol({Key? key}) : super(key: key);

  @override
  State<ResponsividadeRowCol> createState() => _ResponsividadeRowColState();
}

class _ResponsividadeRowColState extends State<ResponsividadeRowCol> {
  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Responsividade"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 200,
          ),
          Expanded(
            child: Container(
              color: Colors.orange,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}

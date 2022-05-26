import 'package:flutter/material.dart';

class RegrasLayout extends StatefulWidget {
  const RegrasLayout({Key? key}) : super(key: key);

  @override
  State<RegrasLayout> createState() => _RegrasLayoutState();
}

class _RegrasLayoutState extends State<RegrasLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Layout Builder"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraint) {
            var largura = constraint.maxWidth;
            return Container(
              child: Text(
                largura.toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}

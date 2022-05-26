import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {
  final String? _hint;
  final bool _obscure;
  final Icon? _icone;

  const InputCustomizado(this._hint, this._icone, this._obscure, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscure,
      decoration: InputDecoration(
          icon: _icone,
          border: InputBorder.none,
          hintText: _hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 18,
          )),
    );
  }
}

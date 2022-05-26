import 'package:flutter/material.dart';

class BotaoAnimado extends StatelessWidget {
  late final AnimationController controller;
  late final Animation<double> _largura;
  late final Animation<double> _opacidade;

  BotaoAnimado({Key? key, required this.controller})
      : _largura = Tween<double>(
          begin: 50,
          end: 500,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.5),
          ),
        ),
        _opacidade = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext buildContext, Widget? widget) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        width: _largura.value,
        child: Center(
          child: FadeTransition(
            opacity: _opacidade,
            child: const Text(
              "Entrar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 100, 127, 1),
              Color.fromRGBO(255, 123, 145, 1),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}

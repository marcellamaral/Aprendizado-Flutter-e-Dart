import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ishowapp/botaoAnimado.dart';
import 'package:ishowapp/inputCustomizado.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animationFade;
  late Animation<double> _animationSize;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = Tween<double>(
      begin: 5,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    _animationFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animationSize = Tween<double>(
      begin: 70,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, widget) {
                  return Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "imagens/fundo.png",
                          ),
                          fit: BoxFit.fill),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animation.value,
                        sigmaY: _animation.value,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            child: FadeTransition(
                              opacity: _animationFade,
                              child: Image.asset("imagens/detalhe1.png"),
                            ),
                            left: 10,
                          ),
                          Positioned(
                            child: FadeTransition(
                              opacity: _animationFade,
                              child: Image.asset("imagens/detalhe2.png"),
                            ),
                            left: 40,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _animationSize,
                      builder: (context, widget) {
                        return Container(
                          width: _animationSize.value,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 15,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            children: const [
                              InputCustomizado(
                                  "Email", Icon(Icons.person), false),
                              InputCustomizado("Senha", Icon(Icons.lock), true),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BotaoAnimado(
                      controller: _animationController,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Esqueci minha senha!",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 100, 127, 1),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

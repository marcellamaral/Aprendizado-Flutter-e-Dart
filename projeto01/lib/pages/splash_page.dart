import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto01/services/prefs_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => {
        PrefsService.isAuth().then(
          (value) {
            value
                ? Navigator.pushReplacementNamed(context, '/home')
                : Navigator.pushReplacementNamed(context, '/login');
          },
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade600,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white54,
        ),
      ),
    );
  }
}

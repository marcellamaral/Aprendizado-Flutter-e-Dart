import 'package:flutter/material.dart';

import '../main.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (_) => const MyWidget(),
    '/notificacao': (_) => Scaffold(
          appBar: AppBar(),
          body: const SizedBox.expand(
            child: Center(
              child: Text('Virtual Page'),
            ),
          ),
        ),
  };
}

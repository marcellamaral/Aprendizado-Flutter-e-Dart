import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_firebase_instalacao_automatica/notification_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
            create: (context) => NotificationService()),
      ],
      child: const App(),
    ),
  );
}

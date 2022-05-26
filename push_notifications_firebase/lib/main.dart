import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notifications_firebase/firebase_options.dart';
import 'package:push_notifications_firebase/services/firebase_messaging/custom_firebase_messaging.dart';

import 'routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CustomFirebaseMessaging().inicialize();

  await CustomFirebaseMessaging().getTokenFirebase();
  runApp(
    MaterialApp(
      title: 'Push Notification',
      navigatorKey: navigatorKey,
      routes: Routes.list,
      initialRoute: '/home',
    ),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notification'),
      ),
    );
  }
}

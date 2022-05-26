import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_firebase_instalacao_automatica/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool valor = false;

  showNotification() {
    setState(() {
      valor = !valor;
      if (valor) {
        Provider.of<NotificationService>(context, listen: false)
            .showNotification(
          CustomNotification(
            id: 1,
            title: 'Teste',
            body: 'Acesse o app!',
            payload: '/notificacao',
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 174),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: ListTile(
              title: const Text('Lembrar-me mais tarde'),
              trailing: valor
                  ? Icon(
                      Icons.check,
                      color: Colors.amber.shade600,
                    )
                  : const Icon(Icons.check_box_outline_blank),
              onTap: showNotification,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:projeto01/controllers/login_controller.dart';

class CustomLoginButtonComponent extends StatelessWidget {
  const CustomLoginButtonComponent({super.key, required this.loginController});

  final LoginController loginController;

  final snackBar = const SnackBar(
    backgroundColor: Colors.red,
    duration: Duration(seconds: 5),
    content: Text("Falha ao realizar o login!"),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: loginController.inLoader,
        builder: (_, bool value, __) {
          return value
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => loginController.auth().then((result) {
                        if (result == true) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }),
                  child: const Text('Login'));
        });
  }
}

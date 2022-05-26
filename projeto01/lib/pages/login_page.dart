import 'package:flutter/material.dart';
import 'package:projeto01/components/login/custom_login_button_component.dart';
import 'package:projeto01/controllers/login_controller.dart';
import 'package:projeto01/widgets/custom_text_field_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people,
                    size: MediaQuery.of(context).size.height * 0.2),
                CustomTextFieldWidget(
                  onChanged: _loginController.setLogin,
                  label: 'Login',
                ),
                CustomTextFieldWidget(
                  onChanged: _loginController.setPass,
                  label: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                CustomLoginButtonComponent(
                  loginController: _loginController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

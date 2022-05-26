import 'package:calculos_unistamp/routes/routes.dart';
import 'package:calculos_unistamp/utilities/customButton.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            Padding(
              padding: EdgeInsets.only(top: 110, bottom: 20),
              child: Column(
                children: [
                  CustomButton(
                    textCustomBT: "Calcular Tonelagem",
                    route: Routes.tonelagemPage,
                  ),
                  CustomButton(
                    textCustomBT: "Calcular Espessura",
                    route: Routes.espessuraPage,
                  ),
                  CustomButton(
                    textCustomBT: "Calcular Comprimento",
                    route: Routes.comprimentoPage,
                  ),
                  CustomButton(
                    textCustomBT: "Calcular Abertura",
                    route: Routes.aberturaPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

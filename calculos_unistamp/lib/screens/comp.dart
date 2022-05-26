import 'package:calculos_unistamp/utilities/auxInfo.dart';
import 'package:calculos_unistamp/utilities/resultMax.dart';
import 'package:calculos_unistamp/src/analiseDados.dart';
import 'package:calculos_unistamp/utilities/customButton.dart';
import 'package:calculos_unistamp/utilities/showMaterials.dart';
import 'package:calculos_unistamp/utilities/textFieldCustom.dart';
import 'package:flutter/material.dart';

class Comprimento extends StatelessWidget {
  Comprimento({Key? key}) : super(key: key);

  final TextEditingController _controllerTonelagem = TextEditingController();
  final TextEditingController _controllerEspessura = TextEditingController();
  final TextEditingController _controllerCanal = TextEditingController();
  final TextEditingController _controllerMaterial = TextEditingController();

  final AnaliseDeDados dados = AnaliseDeDados();

  go(String opc) {
    String ton = _controllerTonelagem.text;
    String esp = _controllerEspessura.text;
    String can = _controllerCanal.text;
    String mat = _controllerMaterial.text;

    dados.tonelagem = ton;
    dados.espessura = esp;
    dados.canal = can;
    dados.material = mat;

    dados.verificarCampos(opc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        title: const Text(
          "CÁLCULO COMPRIMENTO DE DOBRA",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFieldCustom(
                  controller: _controllerTonelagem,
                  labelText: "Tonelagem",
                  suffixText: "ton",
                ),
                TextFieldCustom(
                  controller: _controllerEspessura,
                  labelText: "Espessura",
                  suffixText: "mm",
                ),
                TextFieldCustom(
                  controller: _controllerCanal,
                  labelText: "Canal",
                  suffixText: "mm",
                ),
                TextFieldCustom(
                  controller: _controllerMaterial,
                  labelText: "Material",
                  suffixText: "Kgf/mm²",
                ),
                ResultMax(
                  result: dados.comprimentoMaximo,
                  text: "Comprimento Máx.: ",
                  measure: "mts",
                ),
                AuxInfo(
                  raioInterno: dados.raioInterno,
                  bordoMin: dados.bordoMinimo,
                ),
                CustomButtonCalcular(
                  textCustomBT: "Calcular",
                  function: () => go("com"),
                ),
                const showMaterials(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

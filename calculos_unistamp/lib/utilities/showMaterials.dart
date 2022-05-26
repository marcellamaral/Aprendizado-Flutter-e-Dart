import 'package:calculos_unistamp/src/materialTable.dart';
import 'package:flutter/material.dart';

class showMaterials extends StatelessWidget {
  const showMaterials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(2),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: materialTable.length,
        itemBuilder: (context, indice) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(materialTable[indice][0]),
                Text(materialTable[indice][1]),
              ],
            ),
          );
        },
      ),
    );
  }
}

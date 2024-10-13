import 'package:flutter/material.dart';

void routeDialogLoading(BuildContext context){
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_)=>
        const AlertDialog.adaptive(
          title: Text("Un momento porfavor"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Calculadon ruta destino"),
              SizedBox(height: 10),
              CircularProgressIndicator.adaptive()
            ],
          ),
        )
    );
    return;

}


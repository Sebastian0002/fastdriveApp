import 'package:flutter/material.dart';

void routeDialogLoading(BuildContext context){
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_)=>
        const AlertDialog.adaptive(
          title: Text("Please wait a moment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Calculating route to destination"),
              SizedBox(height: 10),
              CircularProgressIndicator.adaptive()
            ],
          ),
        )
    );
    return;

}


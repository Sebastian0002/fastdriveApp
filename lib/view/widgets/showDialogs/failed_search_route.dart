import 'package:flutter/material.dart';

void failedDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (ctx)=>
        AlertDialog.adaptive(
          actions: [
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () => Navigator.pop(ctx)),
          ],
          title: const Center(child: Text("Error calculating the destination route", textAlign: TextAlign.center)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "An error occurred while calculating the destination route. Please check your internet connection. If the error persists, contact the administrator",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        )
    );
    return;

}


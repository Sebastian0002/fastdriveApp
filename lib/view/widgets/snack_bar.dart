
import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  
  CustomSnackBar({
    super.key,
    String? message,
    EdgeInsets? margin,
    ShapeBorder? shape,
    Duration? duration,
    SnackBarBehavior? behavior,
  }) : 
  super(
    width: 200,
    content: Center(child: Text( message ?? 'message')),
    behavior: SnackBarBehavior.floating,
    shape: shape ?? const StadiumBorder(),
    duration: duration ?? const Duration(seconds: 3)
    );
}
import 'package:flutter/material.dart';

class CircularSimpleMarker extends CustomPainter {
  final Color centerCircularPainter;

  CircularSimpleMarker({super.repaint, required this.centerCircularPainter});
  
  @override
  void paint(Canvas canvas, Size size) {
    
      final whitePencil = Paint()..color = Colors.white;
      final customPencil = Paint()..color = centerCircularPainter;
      
      final containerHeight = size.height;
      final containerWidth = size.width;
      const double circularRadius = 10;

      canvas.drawCircle(Offset(containerWidth * 0.5, containerHeight - circularRadius), circularRadius, whitePencil);
      canvas.drawCircle(Offset(containerWidth * 0.5, containerHeight - circularRadius), circularRadius-5, customPencil);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
  
}
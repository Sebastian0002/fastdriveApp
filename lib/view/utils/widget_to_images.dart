import 'dart:ui' as ui;

import 'package:fastdrive/view/utils/markers/markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


Future<BitmapDescriptor> getCircularSimpleCustomMarker(ui.Color color) async {

  final recoder = ui.PictureRecorder();
  final canvas = ui.Canvas( recoder );
  const size = ui.Size(20, 20);

  final startMarker = CircularSimpleMarker(centerCircularPainter:  color);
  startMarker.paint(canvas, size);

  final picture = recoder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData( format: ui.ImageByteFormat.png );

  return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());

}
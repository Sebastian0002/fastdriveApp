
import 'package:fastdrive/data/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestiny {
  final List<LatLng> polyline;
  final double duration;
  final double distance;
  final Feature endPlace;
  RouteDestiny({
    required this.polyline, 
    required this.duration, 
    required this.distance,
    required this.endPlace
    });
}


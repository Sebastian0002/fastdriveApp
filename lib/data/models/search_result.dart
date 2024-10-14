import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final bool manual;
  final LatLng? destination;
  final String? placeName;
  final String? placeShortDescription;

  SearchResult({
    required this.cancel, 
    this.manual = false,
    this.destination,
    this.placeName,
    this.placeShortDescription
  });

}
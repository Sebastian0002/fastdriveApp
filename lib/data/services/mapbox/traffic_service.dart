import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fastdrive/constants/env_constants.dart';
import 'package:fastdrive/data/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'traffic_interceptor.dart';
part 'places_interceptor.dart';

class TrafficService {

  final Dio _traffic;
  final Dio _places;
  final String _trafficBaseUrl = "https://api.mapbox.com/directions/v5/mapbox";
  final String _placesBaseUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places";
  TrafficService() 
    : _traffic = Dio()..interceptors.add(_TrafficInterceptor()),
     _places = Dio()..interceptors.add(_PlacesInterceptor());


  Future<TrafficResponse> getRoutebyLtLng({required LatLng start, required LatLng end}) async{
    
    TrafficResponse data;
    try {
      final String coordinates = "${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
      final res = await _traffic.get("$_trafficBaseUrl/driving/$coordinates");
      data = TrafficResponse.fromMap(res.data);
      
    } on DioException catch(e){
      log(e.toString());
      data = TrafficResponse.empty();
    }
    
    return data;

  } 

  Future<List<Feature>> getSearchResults({ required LatLng proximity, String query = ''}) async{

    if(query.isEmpty) return [];

    final url = '$_placesBaseUrl/$query.json';
    final res = await _places.get(url, queryParameters: {
      'proximity': '${proximity.longitude},${proximity.latitude}'
    });
    final data = PlacesResponse.fromMap(res.data);
    
    return data.features;
  }

}
import 'package:dio/dio.dart';
import 'package:fastdrive/data/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'traffic_interceptor.dart';

class TrafficService {

  final Dio _traffic;
  final String _trafficBaseUrl = "https://api.mapbox.com/directions/v5/mapbox";
  TrafficService() 
    : _traffic = Dio()..interceptors.add(_TrafficInterceptor());


  Future<TrafficResponse> getRoutebyLtLng({required LatLng start, required LatLng end}) async{

    final String coordinates = "${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
    final res = await _traffic.get("$_trafficBaseUrl/driving/$coordinates");
    final TrafficResponse data = TrafficResponse.fromMap(res.data);

    return data;

  } 


}
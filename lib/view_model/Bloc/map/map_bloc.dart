import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastdrive/data/models/models.dart';
import 'package:fastdrive/view_model/Bloc/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  late StreamSubscription _subscription;
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  MapBloc({required this.locationBloc}) : super(const MapInitState()) {
    on<OnMapInitEvent>(_onInitMap);
    on<OnMapFollowingEvent>(_onFollowing);
    on<UpdatePolylinesEvent>(_onUpdatePolylines);
    on<OnshowPolylines>((event,emit) => emit(state.copyWith(isShowMyroute: event.isShowPolylines)));
    on<OnNewRoute>((event,emit) => emit(state.copyWith(polylines: event.routes, markers: event.markers)));
    

    _subscription = locationBloc.stream.listen(( locationState ){
      if(locationState.lastLocation != null){
        add(UpdatePolylinesEvent(userHistoryLocation: locationState.locationHistory));
      }

      if(!state.isFollowingUser) return;
      if(locationState.lastLocation == null) return;
      focusUser();
    });

  }

  _onInitMap(OnMapInitEvent event, Emitter<MapState> emit){
    _mapController = event.controller;
    emit(state.copyWith(isInitMap: true));
  }
  
  _onFollowing(OnMapFollowingEvent event, Emitter<MapState> emit) => 
    emit(state.copyWith(isFollowingUser: event.isFollowing));
  
  _onUpdatePolylines(UpdatePolylinesEvent event, Emitter<MapState> emit){
    
    final myRoute = Polyline(
      polylineId: const PolylineId("myRoute"),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userHistoryLocation
      );
      
      final currentRoute = Map<String,Polyline>.from(state.polylines);
      currentRoute['myRoute'] = myRoute;
      emit(state.copyWith(polylines: currentRoute));
  }

  Future drawRoute( RouteDestiny  route ) async { 

    final myRoute = Polyline(
      polylineId: const PolylineId("route"),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: route.polyline
      );

      final currentRoute = Map<String,Polyline>.from(state.polylines);
      currentRoute['route'] = myRoute;

      final startMarker = Marker(
        markerId: const MarkerId('start'),
        position: route.polyline.first,);
      
      final finalMarker = Marker(
        markerId: const MarkerId('end'),
        position: route.polyline.last,
        infoWindow: InfoWindow(
          title: "",
          snippet: ""
        )
        );
      
      final currentmarkers = Map<String,Marker>.from(state.markers);
      currentmarkers['start'] = startMarker;
      currentmarkers['ende'] = finalMarker;

      
      add(OnNewRoute(routes: currentRoute, markers: currentmarkers));

  }


  void focusUser(){
    if(locationBloc.state.lastLocation == null) return;
    CameraUpdate camera = CameraUpdate.newLatLngZoom(locationBloc.state.lastLocation!, 16);
    _mapController?.animateCamera(camera);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


}

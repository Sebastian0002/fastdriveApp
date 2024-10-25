import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastdrive/constants/map_list_style.dart';
import 'package:fastdrive/data/models/models.dart';
import 'package:fastdrive/view/utils/widget_to_images.dart';
import 'package:fastdrive/view_model/Bloc/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  late StreamSubscription _subscription;
  late BitmapDescriptor  _finalMarkerIcon;
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  MapBloc({required this.locationBloc}) : super(MapInitState(listCardMapModel: listStyleMap)) {
    on<OnMapInitEvent>(_onInitMap);
    on<OnMapFollowingEvent>(_onFollowing);
    on<UpdatePolylinesEvent>(_onUpdatePolylines);
    on<OnshowPolylines>((event,emit) => emit(state.copyWith(isShowMyroute: event.isShowPolylines)));
    on<OnNewRoute>((event,emit) => emit(state.copyWith(polylines: event.routes, markers: event.markers)));
    on<OnMoveMapEvent>(_onMoveCamera);
    on<OnMapStyleChange>(_onNewMapSelected);
    

    _subscription = locationBloc.stream.listen(( locationState ){
      if(locationState.lastLocation != null){
        add(UpdatePolylinesEvent(userHistoryLocation: locationState.locationHistory));
      }

      if(!state.isFollowingUser) return;
      if(locationState.lastLocation == null) return;
      focusUser();
    });

  }

  _onInitMap(OnMapInitEvent event, Emitter<MapState> emit) async{
    _mapController = event.controller;
    emit(state.copyWith(isInitMap: true));
    _finalMarkerIcon = await getCircularSimpleCustomMarker(Colors.green.shade400);
  }
  
  _onFollowing(OnMapFollowingEvent event, Emitter<MapState> emit) => 
    emit(state.copyWith(isFollowingUser: event.isFollowing));
  
  _onMoveCamera(OnMoveMapEvent event, Emitter<MapState> emit) {
    if(event.actualPosition == null) return;
    emit(state.copyWith(actualPosition: event.actualPosition));
  }
  
  _onNewMapSelected(OnMapStyleChange event, Emitter<MapState> emit) {
    if(state.listCardMapModel.isEmpty) return;
    final List<CardMapModel> list = [];

    for(var map in state.listCardMapModel) {      
      if(map == event.cardMapModelSelected){
        if(map.isSelected)return;
        list.add( map.copyWith(isSelected: true));
      }
      else{
        list.add(map.copyWith(isSelected: false));
      }
    }
    
    emit(state.copyWith(listCardMapModel: list));
  }
  
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
      
      final finalMarker = Marker(
        markerId: const MarkerId('end'),
        position: route.polyline.last,
        icon: _finalMarkerIcon,
        infoWindow: InfoWindow(
          title: route.endPlace.text,
          snippet: route.endPlace.placeName
        )
        );
      
      final currentmarkers = Map<String,Marker>.from(state.markers);
      currentmarkers['end'] = finalMarker;      
      add(OnNewRoute(routes: currentRoute, markers: currentmarkers));

  }


  void focusUser(){
    if(locationBloc.state.lastLocation == null) return;
    CameraUpdate camera = CameraUpdate.newLatLngZoom(locationBloc.state.lastLocation!, 16);
    _mapController?.animateCamera(camera);
  }
  
  void focusNorth()async{
    if (state.actualPosition == null || _mapController == null) return;
    final CameraPosition cameraPositionNorth = CameraPosition(target:state.actualPosition!.target, bearing: 0, zoom: state.actualPosition!.zoom);
    CameraUpdate camera = CameraUpdate.newCameraPosition(cameraPositionNorth);
    _mapController?.animateCamera(camera);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


}

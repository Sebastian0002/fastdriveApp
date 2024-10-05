import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  
  StreamSubscription? subscription;

  LocationBloc() : super(const LocationInitState()) {
    on<FollowingUserEvent>((event, emit)=>emit(state.copyWith(isFollowingUser: event.followingUser)));
    on<OnNewLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastLocation: event.newLocation,
        locationHistory: [...state.locationHistory, event.newLocation]
      ));
    });
  }

  // Future getUserPosition () async{
  //    final position = await Geolocator.getCurrentPosition();
  //      add(OnNewLocationEvent(newLocation: LatLng(position.latitude, position.longitude)));
  // }

  void startFollowingUser(){
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high, 
      distanceFilter: 10);

    subscription = Geolocator.getPositionStream(locationSettings: settings).listen((event){
      add(OnNewLocationEvent(newLocation: LatLng(event.latitude, event.longitude)));
    });
    add(const FollowingUserEvent(followingUser: true));
  }
  
  void stopFollowingUser(){
    add(const FollowingUserEvent(followingUser: false));
    subscription?.cancel();
  }

 

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }

}

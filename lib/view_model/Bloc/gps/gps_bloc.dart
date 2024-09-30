import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(const GpsInitState()) {
    // on<GpsEvent>((event, emit) {
    // });
    on<GpsPermissionEvent>((event, emit) => emit(state.copyWhit(
      isLocationEnabled: event.isLocationEnabled,
      isLocationPermissionGranted: event.isLocationPermissionGranted
    )));
    _init();
  }

  Future<void> _init ()async{
    final bool res = await _checkLocationStatus();
    log("primer respuesta = $res");
  }
  
  Future<bool> _checkLocationStatus ()async{
    bool response = await Geolocator.isLocationServiceEnabled(); 

    final Stream<ServiceStatus> subscription = Geolocator.getServiceStatusStream();
    subscription.listen((event){
    });

    return response;

  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  


}

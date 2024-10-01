import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? _subscriptionPermissionChannel;
  StreamSubscription? _subscriptionServicesChannel;
  static const EventChannel _permissionsChannel = EventChannel("com.fastdrive.location/permissions");
  static const String _permissionHandler = "permissions";

  GpsBloc() : super(const GpsInitState()) {
    on<GpsPermissionEvent>((event, emit) => emit(state.copyWhit(
      isLocationEnabled: event.isLocationEnabled,
      isLocationPermissionGranted: event.isLocationPermissionGranted
    )));
    _init();
  }

  Future<void> _init ()async{

   _subscriptionPermissionChannel = _permissionsChannel.receiveBroadcastStream(_permissionHandler).listen((event){
        add(GpsPermissionEvent(
          isLocationEnabled: state.isLocationEnabled,
          isLocationPermissionGranted: event));
      });

     _subscriptionServicesChannel = Geolocator.getServiceStatusStream().listen((data){
        final bool event = data == ServiceStatus.enabled;
        add(GpsPermissionEvent(
          isLocationEnabled: event,
          isLocationPermissionGranted: state.isLocationPermissionGranted));
      });
  }

  Future<void> askForPermission()async{
    final res = await permission.Permission.location.request();

    switch (res) {
      case permission.PermissionStatus.granted:
        add(GpsPermissionEvent(isLocationEnabled: state.isLocationEnabled, isLocationPermissionGranted: true));
        break;
      case permission.PermissionStatus.denied:
      case permission.PermissionStatus.restricted:
      case permission.PermissionStatus.limited:
      case permission.PermissionStatus.permanentlyDenied:
      case permission.PermissionStatus.provisional:
        add(GpsPermissionEvent(isLocationEnabled: state.isLocationEnabled, isLocationPermissionGranted: false));
        permission.openAppSettings();
    }
  }

  @override
  Future<void> close() {
    _subscriptionPermissionChannel?.cancel();
    _subscriptionServicesChannel?.cancel();
    return super.close();
  }

}

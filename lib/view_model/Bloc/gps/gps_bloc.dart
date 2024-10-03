import 'dart:async';
import 'dart:io';

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

  GpsBloc() : super(const GpsInitState()) {
    on<GpsPermissionEvent>((event, emit) => emit(state.copyWhit(
      isGpsEnabled: event.isGpsEnabled,
      isGpsPermissionGranted: event.isGpsPermissionGranted
    )));
    _init();
  }

  Future<void> _init ()async{

    if(Platform.isAndroid){
      final gpsInitStatus = await Future.wait([
        _checkGpsStatus(),
        _isPermissionGranted(),
    ]);
    add( GpsPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
    ));
    }

    _LocationPermissions.listenToLocationPermissions((event){
        add(GpsPermissionEvent(
        isGpsEnabled: state.isGpsEnabled,
        isGpsPermissionGranted: event));
    });

    _subscriptionServicesChannel = Geolocator.getServiceStatusStream().listen((data){
      final bool event = data == ServiceStatus.enabled;
      add(GpsPermissionEvent(
        isGpsEnabled: event,
        isGpsPermissionGranted: state.isGpsPermissionGranted));
    });
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    return isEnable;  
  }
   Future<bool> _isPermissionGranted() async {
    final isGranted = await permission.Permission.location.isGranted;
    return isGranted;
  }

  Future<void> askForPermission()async{
    final res = await permission.Permission.location.request();

    switch (res) {
      case permission.PermissionStatus.granted:
        add(GpsPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;
      case permission.PermissionStatus.denied:
      case permission.PermissionStatus.restricted:
      case permission.PermissionStatus.limited:
      case permission.PermissionStatus.permanentlyDenied:
      case permission.PermissionStatus.provisional:
        add(GpsPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
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

class _LocationPermissions {
  static const EventChannel _eventChannel = EventChannel('com.fastdrive.location/permissions');

  static void listenToLocationPermissions(void Function(dynamic) onPermissionChanged) {
    _eventChannel.receiveBroadcastStream().listen(onPermissionChanged);
  }
}

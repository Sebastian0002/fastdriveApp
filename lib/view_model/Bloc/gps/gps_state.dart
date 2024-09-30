part of 'gps_bloc.dart';

sealed class GpsState extends Equatable {
  
  final bool isLocationEnabled;
  final bool isLocationPermissionGranted;

  
  const GpsState({
    required this.isLocationEnabled, 
    required this.isLocationPermissionGranted
  });

  GpsState copyWhit({
    bool ? isLocationEnabled,
    bool ? isLocationPermissionGranted
  }) => GpsInitState(
    isLocationEnabledinitial: isLocationEnabled ?? this.isLocationEnabled,
    isLocationPermissionGrantedinitial: isLocationPermissionGranted ?? this.isLocationPermissionGranted);

  @override
  String toString() => "{isLocationEnabled: $isLocationEnabled, isLocationPermissionGranted: $isLocationPermissionGranted}";

  @override
  List<Object> get props => [isLocationEnabled, isLocationPermissionGranted];
}

class GpsInitState extends GpsState{
  final bool? isLocationEnabledinitial;
  final bool? isLocationPermissionGrantedinitial;

  const GpsInitState({this.isLocationEnabledinitial, this.isLocationPermissionGrantedinitial}) : 
    super(isLocationEnabled: isLocationEnabledinitial ?? false, isLocationPermissionGranted: isLocationPermissionGrantedinitial ?? false);
}

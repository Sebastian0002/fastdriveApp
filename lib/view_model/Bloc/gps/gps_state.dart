part of 'gps_bloc.dart';

sealed class GpsState extends Equatable {
  
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;
  
  const GpsState({
    this.isGpsEnabled = false, 
    this.isGpsPermissionGranted = false
  });

  GpsState copyWhit({
    bool ? isGpsEnabled,
    bool ? isGpsPermissionGranted
  }) => GpsInitState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
    isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted);

  @override
  String toString() => "{isLocationEnabled: $isGpsEnabled, isLocationPermissionGranted: $isGpsPermissionGranted}";

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];
}

class GpsInitState extends GpsState{
  const GpsInitState({super.isGpsEnabled, super.isGpsPermissionGranted}); 
}

part of 'gps_bloc.dart';

sealed class GpsState extends Equatable {
  
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;
  
  const GpsState({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted
  });

  GpsState copyWhit({
    bool ? isGpsEnabled,
    bool ? isGpsPermissionGranted
  }) => GpsInitState(
    isGpsEnabledinitial: isGpsEnabled ?? this.isGpsEnabled,
    isGpsPermissionGrantedinitial: isGpsPermissionGranted ?? this.isGpsPermissionGranted);

  @override
  String toString() => "{isLocationEnabled: $isGpsEnabled, isLocationPermissionGranted: $isGpsPermissionGranted}";

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];
}

class GpsInitState extends GpsState{
  final bool? isGpsEnabledinitial;
  final bool? isGpsPermissionGrantedinitial;

  const GpsInitState({this.isGpsEnabledinitial, this.isGpsPermissionGrantedinitial}) : 
    super(isGpsEnabled: isGpsEnabledinitial ?? false, isGpsPermissionGranted: isGpsPermissionGrantedinitial ?? false);
}

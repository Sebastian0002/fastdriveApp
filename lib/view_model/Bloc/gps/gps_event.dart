part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}


class GpsPermissionEvent extends GpsEvent {

  final bool? isLocationEnabled;
  final bool? isLocationPermissionGranted;

  const GpsPermissionEvent({
    required this.isLocationEnabled, 
    required this.isLocationPermissionGranted
  });

}

part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  
  final bool isFollowingUser;
  final LatLng? lastLocation;
  final List<LatLng> locationHistory;
  
  const LocationState({
    this.isFollowingUser = false,
    this.locationHistory = const [],
    this.lastLocation
  });

  LocationState copyWith ({
    bool? isFollowingUser,
    LatLng? lastLocation,
    List<LatLng>? locationHistory
  })=>  
  LocationInitState(
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      lastLocation: lastLocation ?? this.lastLocation,
      locationHistory: locationHistory ?? this.locationHistory
    );


  @override
  List<Object?> get props => [isFollowingUser, lastLocation, locationHistory];
}

final class LocationInitState extends LocationState {

  const LocationInitState({
    super.isFollowingUser,
    super.lastLocation,
    super.locationHistory
    });

}

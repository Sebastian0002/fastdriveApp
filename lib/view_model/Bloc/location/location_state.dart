part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  
  final bool isFollowingUser;
  final LatLng? lastLocation;
  final List<LatLng> locationHistory;
  
  const LocationState({
    required this.isFollowingUser,
    required this.locationHistory,
    this.lastLocation
  });

  LocationState copyWith ({
    bool? isFollowingUser,
    LatLng? lastLocation,
    List<LatLng>? locationHistory
  })=>  
  LocationInitState(
      isFollowingUserinit: isFollowingUser ?? this.isFollowingUser,
      lastLocationinit: lastLocation ?? this.lastLocation,
      locationHistoryinit: locationHistory ?? this.locationHistory
    );


  @override
  List<Object?> get props => [isFollowingUser, lastLocation, locationHistory];
}

final class LocationInitState extends LocationState {

  final bool isFollowingUserinit;
  final LatLng? lastLocationinit;
  final List<LatLng> locationHistoryinit;

  const LocationInitState({
    this.isFollowingUserinit = false,
    this.lastLocationinit,
    this.locationHistoryinit =  const []
    }) : super(
      isFollowingUser: isFollowingUserinit, 
      lastLocation: lastLocationinit, 
      locationHistory: locationHistoryinit);

}

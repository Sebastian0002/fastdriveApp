part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewLocationEvent extends LocationEvent {
  final LatLng newLocation;
  const OnNewLocationEvent({required this.newLocation});
}

class FollowingUserEvent extends LocationEvent {
  final bool followingUser;
  const FollowingUserEvent({required this.followingUser});
}

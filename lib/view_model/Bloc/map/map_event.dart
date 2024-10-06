part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}


class OnMapInitEvent extends MapEvent{
  final GoogleMapController controller;
  const OnMapInitEvent({required this.controller});
}

class OnMapFollowingEvent extends MapEvent{
  final bool isFollowing;
  const OnMapFollowingEvent({required this.isFollowing});
}

class UpdatePolylinesEvent extends MapEvent{
  final List<LatLng> userHistoryLocation;
  const UpdatePolylinesEvent({required this.userHistoryLocation});
}

class OnshowPolylines extends MapEvent{
  final bool isShowPolylines;
  const OnshowPolylines({required this.isShowPolylines});
}

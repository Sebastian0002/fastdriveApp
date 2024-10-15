part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  final bool isInitMap;
  final bool isFollowingUser;
  final bool isShowMyroute;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.isInitMap = false, 
    this.isFollowingUser = false,
    this.isShowMyroute = false,
    this.polylines = const {},
    this.markers = const {},
  });
  
  MapState copyWith ({
    bool? isInitMap,
    bool? isFollowingUser,
    bool? isShowMyroute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) => 
    MapInitState(
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      isInitMap: isInitMap ?? this.isInitMap,
      isShowMyroute: isShowMyroute ?? this.isShowMyroute,
      polylines: polylines ?? this.polylines,
      markers: markers ?? this.markers,
    );

  @override
  List<Object> get props => [isInitMap, isFollowingUser, polylines, isShowMyroute, markers];
}

final class MapInitState extends MapState {
  const MapInitState({
    super.isFollowingUser,
    super.isInitMap,
    super.isShowMyroute,
    super.polylines,
    super.markers,
  });

}

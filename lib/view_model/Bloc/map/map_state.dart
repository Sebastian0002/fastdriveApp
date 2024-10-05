part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  final bool isInitMap;
  final bool isFollowingUser;
  final Map<String, Polyline> polylines;

  const MapState({
    required this.isInitMap, 
    required this.isFollowingUser,
    required this.polylines
  });
  
  MapState copyWith ({
    bool? isInitMap,
    bool? isFollowingUser,
    Map<String, Polyline>? polylines,
  }) => 
    MapInitState(
      isFollowingUserinit: isFollowingUser ?? this.isFollowingUser,
      isInitMapinit: isInitMap ?? this.isInitMap,
      polylinesinit: polylines ?? this.polylines
    );

  @override
  List<Object> get props => [isInitMap, isFollowingUser, polylines];
}

final class MapInitState extends MapState {
  final bool isInitMapinit;
  final bool isFollowingUserinit;
  final Map<String, Polyline> polylinesinit;
  const MapInitState({
    this.isFollowingUserinit = false,
    this.isInitMapinit = false,
    this.polylinesinit = const {}
  }) : super(isFollowingUser: isFollowingUserinit, isInitMap: isInitMapinit, polylines: polylinesinit);

}

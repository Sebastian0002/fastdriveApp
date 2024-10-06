part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  final bool isInitMap;
  final bool isFollowingUser;
  final bool isShowMyroute;
  final Map<String, Polyline> polylines;

  const MapState({
    required this.isInitMap, 
    required this.isFollowingUser,
    required this.polylines,
    required this.isShowMyroute
  });
  
  MapState copyWith ({
    bool? isInitMap,
    bool? isFollowingUser,
    bool? isShowMyroute,
    Map<String, Polyline>? polylines,
  }) => 
    MapInitState(
      isFollowingUserinit: isFollowingUser ?? this.isFollowingUser,
      isInitMapinit: isInitMap ?? this.isInitMap,
      polylinesinit: polylines ?? this.polylines,
      isShowMyrouteinit: isShowMyroute ?? this.isShowMyroute
    );

  @override
  List<Object> get props => [isInitMap, isFollowingUser, polylines, isShowMyroute];
}

final class MapInitState extends MapState {
  final bool isInitMapinit;
  final bool isFollowingUserinit;
  final bool isShowMyrouteinit;
  final Map<String, Polyline> polylinesinit;
  const MapInitState({
    this.isFollowingUserinit = false,
    this.isInitMapinit = false,
    this.polylinesinit = const {},
    this.isShowMyrouteinit = false
  }) : super(isFollowingUser: isFollowingUserinit, isInitMap: isInitMapinit, polylines: polylinesinit, isShowMyroute: isShowMyrouteinit);

}

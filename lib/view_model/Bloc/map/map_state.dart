part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  final bool isInitMap;
  final bool isFollowingUser;
  final bool isShowMyroute;
  final Map<String, Polyline> polylines;

  const MapState({
    this.isInitMap = false, 
    this.isFollowingUser = false,
    this.isShowMyroute = false,
    this.polylines = const {},
  });
  
  MapState copyWith ({
    bool? isInitMap,
    bool? isFollowingUser,
    bool? isShowMyroute,
    Map<String, Polyline>? polylines,
  }) => 
    MapInitState(
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      isInitMap: isInitMap ?? this.isInitMap,
      polylines: polylines ?? this.polylines,
      isShowMyroute: isShowMyroute ?? this.isShowMyroute
    );

  @override
  List<Object> get props => [isInitMap, isFollowingUser, polylines, isShowMyroute];
}

final class MapInitState extends MapState {
  const MapInitState({
    super.isFollowingUser,
    super.isInitMap,
    super.polylines,
    super.isShowMyroute
  });

}

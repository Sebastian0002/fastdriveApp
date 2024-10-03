part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  final bool isInitMap;
  final bool isFollowingUser;
  const MapState({
    required this.isInitMap, 
    required this.isFollowingUser,
  });
  
  MapState copyWith ({
    bool? isInitMap,
    bool? isFollowingUser,
  }) => 
    MapInitState(
      isFollowingUserinit: isFollowingUser ?? this.isFollowingUser,
      isInitMapinit: isInitMap ?? this.isInitMap
    );

  @override
  List<Object> get props => [isInitMap, isFollowingUser];
}

final class MapInitState extends MapState {
  final bool isInitMapinit;
  final bool isFollowingUserinit;
  const MapInitState({
    this.isFollowingUserinit = false,
    this.isInitMapinit = false
  }) : super(isFollowingUser: isFollowingUserinit, isInitMap: isInitMapinit);

}

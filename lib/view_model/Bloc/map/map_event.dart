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

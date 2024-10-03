import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController? _mapController;

  MapBloc() : super(const MapInitState()) {
    on<OnMapInitEvent>(_onInitMap);
  }

  _onInitMap(OnMapInitEvent event, Emitter<MapState> emit){
    _mapController = event.controller;
    emit(state.copyWith(isInitMap: true));
  }

}

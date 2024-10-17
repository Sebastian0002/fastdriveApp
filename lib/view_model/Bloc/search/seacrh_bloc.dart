import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastdrive/data/models/models.dart';
import 'package:fastdrive/data/services/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

part 'seacrh_event.dart';
part 'seacrh_state.dart';

class SeacrhBloc extends Bloc<SeacrhEvent, SeacrhState> {

  TrafficService trafficService = TrafficService();
  
  SeacrhBloc() : super(const SeacrhInitState()) {
    on<OnManualMarkerEvent>((event, emit) {
      emit(state.copyWith(displayManualMarker: event.isMarker));
    });
    on<OnNewPlacesEvent>((event, emit) => emit(state.copyWith(places: event.places)));
    on<OnSelectedPlace>((event, emit) => emit(state.copyWith(isSelectedPlace: event.isSelectedPlace)));
    on<SavePlaceEvent>((event, emit) => emit(state.copyWith(placesHistory: [...state.placesHistory, event.place])));

  }

  Future<RouteDestiny?> getCoors({required LatLng start, required LatLng end}) async{

    final response = await trafficService.getRoutebyLtLng(start: start, end: end);
    final endPlace = await trafficService.getSearchResultsByCoors(place: end);

    if(response.isEmpty)return null;

    final polyline = 
      decodePolyline(response.routes[0].geometry, accuracyExponent: 6)
        .map((e) => LatLng(e[0].toDouble(), e[1].toDouble()))
        .toList();

    return RouteDestiny(
      polyline: polyline, 
      duration: response.routes[0].duration, 
      distance: response.routes[0].distance,
      endPlace: endPlace
    );
  }

  Future getSearchResults( LatLng proximity, String query ) async{
    final res = await trafficService.getSearchResults(proximity: proximity, query: query);
    add(OnNewPlacesEvent(places: res));
  }

  triggerActionToCloseSheet(){
    add(const OnSelectedPlace(isSelectedPlace: true));
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      add(const OnSelectedPlace(isSelectedPlace: false));
    });
  }

}

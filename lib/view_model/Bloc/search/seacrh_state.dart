part of 'seacrh_bloc.dart';

sealed class SeacrhState extends Equatable {
  
  final bool displayManualMarker;
  final bool isSelectedPlace;
  final List<Feature> places;
  final List<Feature> placesHistory;

  const SeacrhState({
    this.displayManualMarker = false,
    this.isSelectedPlace = false,
    this.places = const [],
    this.placesHistory = const []
    });

  SeacrhState copyWith ({
    bool? displayManualMarker,
    bool? isSelectedPlace,
    List<Feature>? places,
    List<Feature>? placesHistory
    }) => 
      SeacrhInitState(
        displayManualMarker: displayManualMarker ?? this.displayManualMarker,
        places: places ?? this.places,
        placesHistory: placesHistory ?? this.placesHistory,
        isSelectedPlace: isSelectedPlace ?? this.isSelectedPlace
      );
  @override
  List<Object> get props => [displayManualMarker, places, isSelectedPlace, placesHistory];
}

final class SeacrhInitState extends SeacrhState {
  const SeacrhInitState({
    super.displayManualMarker, 
    super.isSelectedPlace,
    super.places, 
    super.placesHistory
    });
}

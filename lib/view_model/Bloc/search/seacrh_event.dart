part of 'seacrh_bloc.dart';

sealed class SeacrhEvent extends Equatable {
  const SeacrhEvent();

  @override
  List<Object> get props => [];
}

class OnManualMarkerEvent extends SeacrhEvent {
  final bool isMarker;
  const OnManualMarkerEvent({required this.isMarker});
}

class OnNewPlacesEvent extends SeacrhEvent {
  final List<Feature> places;
  const OnNewPlacesEvent({required this.places});
}

class OnSelectedPlace extends SeacrhEvent {
  final bool isSelectedPlace;
  const OnSelectedPlace({required this.isSelectedPlace});
}

class SavePlaceEvent extends SeacrhEvent {
  final Feature place;
  const SavePlaceEvent({required this.place});
}

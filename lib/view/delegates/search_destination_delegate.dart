import 'package:fastdrive/data/models/search_result.dart';
import 'package:fastdrive/view_model/Bloc/location/location_bloc.dart';
import 'package:fastdrive/view_model/Bloc/search/seacrh_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchDestinationDelegate extends SearchDelegate <SearchResult>{
  
  SearchDestinationDelegate():super(
    searchFieldLabel: "Search...", 
    searchFieldStyle: const TextStyle(fontSize: 16),
    );
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', 
      icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final result = SearchResult(cancel: true);
    return IconButton(
      onPressed: (){
        close(context, result);
      }, 
      icon: Icon(Icons.adaptive.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {

    final searchBloc = context.read<SeacrhBloc>();
    final proximity = context.read<LocationBloc>().state.lastLocation;
    final ScrollController controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await searchBloc.getSearchResults(proximity!, query);
    });

    return BlocBuilder<SeacrhBloc, SeacrhState>(
      builder: (context, state) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 1),
          controller: controller,
          itemCount: state.places.length,
          itemBuilder: (BuildContext context, int index) {
            final place = state.places[index];
            return ListTile(
              leading: const Icon(Icons.location_pin),
              title: Text(place.text),
              subtitle: Text(place.placeName),
              onTap: (){
                  final result = SearchResult(
                    cancel: false,
                    destination: LatLng(place.center[1], place.center[0]),
                    placeName: place.text,
                    placeShortDescription: place.placeName
                  );
                  searchBloc.add(SavePlaceEvent(place: place));
                  close(context, result);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final searchBloc = context.read<SeacrhBloc>();
    final placesHistory = searchBloc.state.placesHistory;

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.search_rounded),
          title: const Text("set a manual marker"),
          onTap: (){
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        Expanded(
          child: ListView.separated(
            itemCount: placesHistory.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              final place = placesHistory[index];
              return ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(place.text),
                subtitle: Text(place.placeName),
                onTap: (){
                  final result = SearchResult(
                    cancel: false,
                    destination: LatLng(place.center[1], place.center[0]),
                    placeName: place.text,
                    placeShortDescription: place.placeName
                  );
                  close(context, result);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

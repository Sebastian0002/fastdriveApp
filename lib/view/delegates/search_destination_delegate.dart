

import 'package:fastdrive/data/models/search_result.dart';
import 'package:flutter/material.dart';

class SearchDestinationDelegate extends SearchDelegate <SearchResult>{
  
  SearchDestinationDelegate():super(
    searchFieldLabel: "Buscar...", 
    searchFieldStyle: const TextStyle(color: Colors.black45, fontSize: 16),
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
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.separated(
      itemCount: 1,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        final result = SearchResult(cancel: false, manual: true);
        return ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: const Text("somewhere"),
          onTap: (){
            close(context, result);
          },
        );
      },
    );
  }
}

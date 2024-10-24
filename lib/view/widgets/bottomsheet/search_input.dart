part of 'search_bottomsheet.dart';

class _WidgetSearchInput extends StatelessWidget {
  const _WidgetSearchInput();

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SeacrhBloc>();

    void doActions(SearchResult? result){
      if(result == null) return;
      
      if(result.manual || result.destination != null){
        searchBloc.triggerActionToCloseSheet();
      }
      searchBloc.add(OnManualMarkerEvent(isMarker: result.manual));
      
      if(result.destination != null){
        pressAndSearchRoute(context, destination: result.destination);
        return;
      } 
    }

    return GestureDetector(
      onTap: () async{
        final result = await showSearch(context: context, delegate: SearchDestinationDelegate());
        doActions(result);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: const[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 5)
            )
          ]
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Where to?", style: TextStyle(color: Colors.black45)),
            Icon(Icons.search)
          ],
        ),
      ),
    );
  }
}
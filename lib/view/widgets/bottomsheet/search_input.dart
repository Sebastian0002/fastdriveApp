part of 'search_bottomsheet.dart';

class _WidgetSearchInput extends StatelessWidget {
  const _WidgetSearchInput();

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SeacrhBloc>();
    return GestureDetector(
      onTap: () async{
        final result = await showSearch(context: context, delegate: SearchDestinationDelegate());
        if(result == null) return;
        searchBloc.add(OnManualMarketEvent(isMarket: result.manual));
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
            Text("Busca tu ruta", style: TextStyle(color: Colors.black45)),
            Icon(Icons.search)
          ],
        ),
      ),
    );
  }
}
part of 'search_bottomsheet.dart';

class _SheetBodyManualRoute extends StatelessWidget {
  const _SheetBodyManualRoute({
    required this.size,
    required this.controller,
  });

  final Size size;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 15),
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _TopContainer(),
          const SizedBox(height: 15),
          SizedBox(
            width: size.width - 120,
            child: MaterialButton(
              shape: const StadiumBorder(),
              color: Colors.black,
              onPressed: () => pressAndSearchRoute(context),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ir a la ruta fijada.",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                  SizedBox(width: 10),
                  Icon(Icons.turn_right_outlined, color: Colors.white)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SheetBodyHome extends StatefulWidget {
  final ScrollController scrollController;
  const _SheetBodyHome({required this.scrollController});

  @override
  State<_SheetBodyHome> createState() => _SheetBodyHomeState();
}

class _SheetBodyHomeState extends State<_SheetBodyHome> {
  final GlobalKey _key = GlobalKey();
  double _widgetHeight = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _key.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _widgetHeight = renderBox.size.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SeacrhBloc>();
    final placesHistory = searchBloc.state.placesHistory;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 15),
      controller: widget.scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            key: _key,
            children: const [
              _TopContainer(),
              SizedBox(height: 15),
            ],
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: [
                const _WidgetSearchInput(),
                const SizedBox(height: 15),
                BlocBuilder<BottomsheetBloc, BottomsheetState>(
                  builder: (context, state) {
                    final size = MediaQuery.of(context).size;
                    return SizedBox(
                      height: (size.height - _widgetHeight) *
                          state.screenOccupiedPercentage,
                      child: placesHistory.isEmpty
                        ? const Text("Make your first search to see your history here")
                        :_ListBodyBottomSheet(seacrhBloc: searchBloc,),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListBodyBottomSheet extends StatelessWidget {
  const _ListBodyBottomSheet({
    required this.seacrhBloc,
  });

  final SeacrhBloc seacrhBloc;

  @override
  Widget build(BuildContext context) {
    final placesHistory = seacrhBloc.state.placesHistory;
    return ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: placesHistory.length,
          itemBuilder: (BuildContext context, int index) {
            final place = placesHistory[index];
            return ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text(place.text),
              subtitle: Text(place.placeName),
              onTap: () {
                final destination = LatLng(place.center[1], place.center[0]);
                pressAndSearchRoute(context, destination: destination);
                seacrhBloc.triggerActionToCloseSheet();
              },
            );
          },
        );
  }
}

class _TopContainer extends StatelessWidget {
  const _TopContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

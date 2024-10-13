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
    final SeacrhBloc seacrhBloc = context.read<SeacrhBloc>();
    final LocationBloc locationBloc = context.read<LocationBloc>();
    final MapBloc mapBloc = context.read<MapBloc>();
    close() => Navigator.pop(context);

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
              onPressed: () async {
                  final start = locationBloc.state.lastLocation;
                  if (start == null) return;
                  final end = mapBloc.mapCenter;
                  if (end == null) return;
                  
                  routeDialogLoading(context);
                  final route  = await seacrhBloc.getCoors(start: start, end: end);
                  await mapBloc.drawRoute(route);
                  seacrhBloc.add(const OnManualMarketEvent(isMarket: false));
                  close();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ir a la ruta fijada.",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
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
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 0,
                          );
                        },
                        itemCount: objs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return objs[index];
                        },
                      ),
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

  final List<ListTile> objs = [
    const ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('Ruta'),
      subtitle: Text('Tiempo estimado: 15 min'),
    ),
    const ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('Ruta'),
      subtitle: Text('Tiempo estimado: 15 min'),
    ),
    const ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('Ruta'),
      subtitle: Text('Tiempo estimado: 15 min'),
    ),
    const ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('Ruta'),
      subtitle: Text('Tiempo estimado: 15 min'),
    ),
    const ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('Ruta'),
      subtitle: Text('Tiempo estimado: 15 min'),
    ),
    const ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('Ruta'),
      subtitle: Text('Tiempo estimado: 15 min'),
    ),
    const ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('Ruta'),
      subtitle: Text('Tiempo estimado: 15 min'),
    ),
  ];
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
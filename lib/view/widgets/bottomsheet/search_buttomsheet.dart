import 'package:animate_do/animate_do.dart';
import 'package:fastdrive/constants/bottomsheet.dart';
import 'package:fastdrive/view/delegates/delegates.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_input.dart';

class WidgetSearchBottomSheet extends StatefulWidget {
  const WidgetSearchBottomSheet({super.key});

  @override
  State<WidgetSearchBottomSheet> createState() =>
      _WidgetSearchBottomSheetState();
}

class _WidgetSearchBottomSheetState extends State<WidgetSearchBottomSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  late double _maxSize;
  late double _minSize;
  late double _initialSize;
  late double _lastExtent;
  late bool _isAnimated;
  @override
  void initState() {
    _maxSize = maxSize;
    _minSize = minSize;
    _initialSize = initialSize;
    _lastExtent = minSize;
    _isAnimated = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: DraggableScrollableSheet(
        controller: _controller,
        expand: false,
        initialChildSize: _initialSize,
        minChildSize: _minSize,
        maxChildSize: _maxSize,
        builder: (BuildContext context, ScrollController scrollController) {
          final bottomSheetBloc = context.read<BottomsheetBloc>();
          final Size size = MediaQuery.of(context).size;
      
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              bottomSheetBloc.add(OnUpdateHeightBottomSheet(
                  screenOccupiedPercentage: notification.extent));
              if (!_isAnimated) {
                if (notification.extent > _lastExtent) {
                  if (_isInRange(notification.extent, notification.minExtent, 0.5))_animateTo(0.5);
                  if (_isInRange(notification.extent, 0.5, notification.maxExtent))_animateTo(notification.maxExtent);
                } else if (notification.extent < _lastExtent) {
                  if (_isInRange(notification.extent, 0.5, notification.maxExtent))_animateTo(0.5);
                  if (_isInRange(notification.extent, notification.minExtent, 0.5))_animateTo(notification.minExtent);
                }
              }
              _lastExtent = notification.extent;
              return true;
            },
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: BlocBuilder<SeacrhBloc, SeacrhState>(
                builder: (context, state) {
                return state.displayManualMarker 
                  ?_SheetBodyManualRoute(size: size)
                  :_SheetBodyHome(scrollController: scrollController);
                },
              )
            ),
          );
        },
      ),
    );
  }

  bool _isInRange(double value, double min, double max) {
    return value >= min && value <= max;
  }

  void _animateTo(double animateValue) {
    _isAnimated = true;
    _controller
        .animateTo(
      animateValue,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _isAnimated = false;
    });
  }
}

class _SheetBodyManualRoute extends StatelessWidget {
  const _SheetBodyManualRoute({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _TopContainer(),
        const SizedBox(height: 15),
        SizedBox(
          width: size.width - 120,
          child: MaterialButton(
            shape: const StadiumBorder(),
            color: Colors.black,
            onPressed: (){
              //todo
            }, 
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ir a la ruta fijada.", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                SizedBox(width: 10),
                Icon(Icons.turn_right_outlined, color: Colors.white)
              ],
            ),
            ),
        )
      ],
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
      final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _widgetHeight = renderBox.size.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            key: _key,
            children: const [
              SizedBox(height: 16),
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
                      height: (size.height - _widgetHeight) * state.screenOccupiedPercentage,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return  const Divider(height: 0,);
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

import 'package:fastdrive/constants/bottomsheet.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_input.dart';

class WidgetSearchBottomSheet extends StatefulWidget {
  const WidgetSearchBottomSheet({super.key});

  @override
  State<WidgetSearchBottomSheet> createState() => _WidgetSearchBottomSheetState();
}

class _WidgetSearchBottomSheetState extends State<WidgetSearchBottomSheet> {
  final DraggableScrollableController _controller = DraggableScrollableController();

  late double _maxSize;
  late double _minSize;
  late double _initialSize;
  late double  _lastExtent;
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
    return DraggableScrollableSheet(
      controller: _controller,
      expand: false,
      initialChildSize: _initialSize,
      minChildSize: _minSize,
      maxChildSize: _maxSize,
      builder: (BuildContext context, ScrollController scrollController) {
        final bottomSheetBloc = context.read<BottomsheetBloc>();

        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            bottomSheetBloc.add(OnUpdateHeightBottomSheet(screenOccupiedPercentage: notification.extent));
            if(!_isAnimated){
              if (notification.extent > _lastExtent) {
                if (_isInRange(notification.extent, notification.minExtent, 0.5)) _animateTo(0.5);
                if (_isInRange(notification.extent, 0.5, notification.maxExtent))_animateTo(notification.maxExtent);
              } 
              else if (notification.extent < _lastExtent) {
                if (_isInRange(notification.extent, 0.5, notification.maxExtent))_animateTo(0.5);
                if (_isInRange(notification.extent, notification.minExtent, 0.5))_animateTo(notification.minExtent);
              }
            }
            _lastExtent = notification.extent;
            return true;
          },
          child: Container(
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
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 16),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _WidgetSearchInput(),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('Ruta'),
                    subtitle: Text('Tiempo estimado: 15 min'),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Destino'),
                    subtitle: Text('Dirección de destino'),
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                    
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Iniciar navegación'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isInRange(double value, double min, double max) {
  return value >= min && value <= max;
  }

  void _animateTo(double animateValue){
      _isAnimated = true;
     _controller.animateTo(
        animateValue,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_){
        _isAnimated = false;
      });
  }

}
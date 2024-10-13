import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:fastdrive/constants/bottomsheet.dart';
import 'package:fastdrive/view/delegates/delegates.dart';
import 'package:fastdrive/view/widgets/showDialogs/dialogs.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_input.dart';
part 'search_bottomsheet_body.dart';

class WidgetSearchBottomSheet extends StatefulWidget {
  const WidgetSearchBottomSheet({super.key});

  @override
  State<WidgetSearchBottomSheet> createState() =>
      _WidgetSearchBottomSheetState();
}

class _WidgetSearchBottomSheetState extends State<WidgetSearchBottomSheet> {
  late DraggableScrollableController _controller;

  late double _maxSize;
  late double _minSize;
  late double _initialSize;
  late double _lastExtent;
  late bool _isAnimated;
  @override
  void initState() {
    _controller = DraggableScrollableController();
    _maxSize = maxSize;
    _minSize = minSize;
    _initialSize = initialSize;
    _lastExtent = minSize;
    _isAnimated = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
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
                    if(state.displayManualMarker){
                      Timer(const Duration(milliseconds: 300), () => _animateTo(_initialSize));
                    }
                    
                    return state.displayManualMarker
                      ?_SheetBodyManualRoute(size: size, controller: scrollController)
                      : _SheetBodyHome(scrollController: scrollController);
                  },
                )              
              )
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
        curve: Curves.easeInOut)
      .then((_) {_isAnimated = false;});
  }
}
import 'package:animate_do/animate_do.dart';
import 'package:fastdrive/view/widgets/FloatingButtons/button_north.dart';
import 'package:fastdrive/view/widgets/widgets.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScreenMap extends StatefulWidget {
  const ScreenMap({super.key});

  @override
  State<ScreenMap> createState() => _ScreenMapState();
}

class _ScreenMapState extends State<ScreenMap> {
  late LocationBloc bloc;

  @override
  void initState() {
    bloc = context.read<LocationBloc>();
    bloc.startFollowingUser();
    super.initState();
  }

  @override
  void dispose() {
    bloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            if (locationState.lastLocation == null) {
              return const Center(
                child: Text("Aguarde un momento"),
              );
            }
    
            return BlocBuilder<MapBloc, MapState>(
              builder: (context, mapState) {
                Map<String, Polyline> polylines = Map.from(mapState.polylines);
    
                if (!mapState.isShowMyroute) {
                  polylines.removeWhere((key, _) => key == 'myRoute');
                }

                return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Stack(
                      children: [
                        WidgetMap(
                          location: locationState.lastLocation!,
                          polylines: polylines.values.toSet(),
                          markers: mapState.markers.values.toSet(),
                        ),
                        const ManualMarker(),
                        const _FloatingButtonsGroup(),
                        const TopButtons()
                      ],
                    ));
              },
            );
          },
        ),
        bottomSheet: Container(
          color: Colors.transparent,
          child: const WidgetSearchBottomSheet()));
  }
}

class _FloatingButtonsGroup extends StatelessWidget {
  const _FloatingButtonsGroup();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomsheetBloc, BottomsheetState>(
      builder: (context, state) {
        final screenSize = MediaQuery.of(context).size;
        return Positioned(
          bottom: state.screenOccupiedPercentage < 0.5
            ? screenSize.height*state.screenOccupiedPercentage
            : screenSize.height*0.5,
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10
            ),
            width: screenSize.width,
            child: BounceInUp(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ButtonFollowingLocation(),
                  SizedBox(height: 10),
                  _FloatingBtnRow(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FloatingBtnRow extends StatelessWidget {
  const _FloatingBtnRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonPolylines(),
        ButtonCenterLocation(),
      ],
    );
  }
}

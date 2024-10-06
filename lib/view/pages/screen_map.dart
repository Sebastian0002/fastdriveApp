import 'package:fastdrive/view/widgets/button_following_location.dart';
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
              
              Map<String,Polyline> polylines = Map.from(mapState.polylines);

              if(!mapState.isShowMyroute){
                polylines.removeWhere((key,_) => key == 'myRoute');
              }

              return SafeArea(
                top: false,
                child: SingleChildScrollView(
                    child: Stack(
                  children: [
                    WidgetMap(
                      location: locationState.lastLocation!,
                      polylines: polylines.values.toSet(),
                    ),
                  ],
                )),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ButtonFollowingLocation(),
            SizedBox(height: 10),
            _FloatingBtnRow(),
          ],
        ),
      ),
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

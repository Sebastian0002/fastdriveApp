import 'package:fastdrive/view/widgets/button_following_location.dart';
import 'package:fastdrive/view/widgets/widgets.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return SafeArea(
                top: false,
                child: SingleChildScrollView(
                    child: Stack(
                  children: [
                    WidgetMap(
                      location: locationState.lastLocation!,
                      polylines: mapState.polylines.values.toSet(),
                    ),
                  ],
                )),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonFollowingLocation(),
          SizedBox(height: 10),
          ButtonCenterLocation(),
        ],
      ),
    );
  }
}

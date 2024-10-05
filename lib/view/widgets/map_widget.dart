import 'dart:convert';

import 'package:fastdrive/view/themes/themes.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetMap extends StatelessWidget {
  final LatLng location;
  final Set<Polyline> polylines;
  
  const WidgetMap({super.key, required this.location, required this.polylines});


  @override
  Widget build(BuildContext context) {

    final size  = MediaQuery.of(context).size;

    final mapBloc = context.read<MapBloc>();

    CameraPosition initialCameraPosition = CameraPosition(
      target: location,
      zoom: 15);

      return Listener(
        onPointerMove: (_) => mapBloc.add(const OnMapFollowingEvent(isFollowing: false)),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            polylines: polylines,
            compassEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) => mapBloc.add(OnMapInitEvent(controller: controller)),
            style: jsonEncode(uberTheme),
          ),
        ),
      );
  }
}
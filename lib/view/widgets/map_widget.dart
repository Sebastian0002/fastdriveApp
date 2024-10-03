import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetMap extends StatelessWidget {
  final LatLng location;
  
  const WidgetMap({super.key, required this.location});


  @override
  Widget build(BuildContext context) {

    final mapBloc = context.read<MapBloc>();

    CameraPosition initialCameraPosition = CameraPosition(
      target: location,
      zoom: 15);

      return GoogleMap(
        initialCameraPosition: initialCameraPosition,
        compassEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (controller) => mapBloc.add(OnMapInitEvent(controller: controller)),
      );
  }
}
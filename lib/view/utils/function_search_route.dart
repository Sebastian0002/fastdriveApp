import 'package:fastdrive/view/widgets/showDialogs/dialogs.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void pressAndSearchRoute(BuildContext context, {LatLng? destination}) async{  
      final SeacrhBloc seacrhBloc = context.read<SeacrhBloc>();
      final LocationBloc locationBloc = context.read<LocationBloc>();
      final MapBloc mapBloc = context.read<MapBloc>();
      close() => Navigator.pop(context);
      failDialog() => failedDialog(context);

      final start = locationBloc.state.lastLocation;
      if (start == null) return;
      final end = destination ?? mapBloc.state.actualPosition?.target;
      if (end == null) return;

      routeDialogLoading(context);
      final route  = await seacrhBloc.getCoors(start: start, end: end);
      seacrhBloc.add(const OnManualMarkerEvent(isMarker: false));
      if(route == null) {
        close();
        failDialog();
        return;
      }
      await mapBloc.drawRoute(route);
      close();
    }
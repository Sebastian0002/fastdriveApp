import 'package:fastdrive/view/widgets/widgets.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCenterLocation extends StatelessWidget {
  const ButtonCenterLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = context.read<MapBloc>();
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        highlightColor: Colors.black12,
        color: Colors.black,
        icon: const Icon(Icons.gps_fixed_outlined),
        onPressed: (){
          final userLocation = mapBloc.locationBloc.state.lastLocation;          
          if(userLocation == null){
            ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar( message: "No se encontro ubicación"));
            return;
          }

          mapBloc.focusUser();

        },  
        
        ),
    );
  }
}

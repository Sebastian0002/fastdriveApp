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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black54,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          highlightColor: Colors.black12,
          color: Colors.black,
          icon: const Icon(Icons.gps_fixed_outlined),
          onPressed: (){          
            if(mapBloc.locationBloc.state.lastLocation == null){
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar( message: "No se encontro ubicación"));
              return;
            }
            mapBloc.focusUser();
          },
          ),
      ),
    );
  }
}

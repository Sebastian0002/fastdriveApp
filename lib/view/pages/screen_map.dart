import 'package:fastdrive/view/widgets/map_widget.dart';
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
        builder: (context, state) {
          
          if(state.lastLocation == null ) {
            return const Center(child: Text("Aguarde un momento"),);
          }

          return SafeArea(
            top: false,
            child: Stack(
              children: [
                WidgetMap(location: state.lastLocation!),
            
                // Positioned(child: child)
              ],
            ),
          );
        },
      )
    );
  }
}
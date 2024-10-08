import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonPolylines extends StatelessWidget {
  const ButtonPolylines({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = context.read<MapBloc>();

    return CircleAvatar(
      backgroundColor: Colors.white,
      child: BlocBuilder<MapBloc, MapState>(
        builder: (_, state) {
          return IconButton(
          highlightColor: Colors.black12,
          color: state.isShowMyroute ? Colors.blueAccent : Colors.black,
          icon: const Icon( Icons.route_rounded),
          onPressed: (){
              mapBloc.add(OnshowPolylines(isShowPolylines: !state.isShowMyroute));
          },
          );
        },
      ),
    );
  }
}

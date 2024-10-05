import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonFollowingLocation extends StatelessWidget {
  const ButtonFollowingLocation({
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
          color: state.isFollowingUser ? Colors.blueAccent : Colors.black,
          icon: Icon(state.isFollowingUser ? Icons.directions_run_rounded : Icons.emoji_people_rounded ),
          onPressed: (){
              mapBloc.add(const OnMapFollowingEvent(isFollowing: true));
              mapBloc.focusUser();
          },
          );
        },
      ),
    );
  }
}

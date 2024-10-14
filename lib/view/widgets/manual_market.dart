import 'package:animate_do/animate_do.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeacrhBloc, SeacrhState>(
      builder: (context, state) {
        return state.displayManualMarker ? const _ManualMarker() : const SizedBox();
      },
    );
  }
}

class _ManualMarker extends StatelessWidget {
  const _ManualMarker();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 50, left: 20, child: _BackButton()),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -19),
              child: BounceInDown(
                  child: const Icon(Icons.location_on_rounded,
                      color: Colors.black, size: 40)),
            ),
          )
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final seacrhBloc = context.read<SeacrhBloc>();
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ]),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
              onPressed: () {
                seacrhBloc.add(const OnManualMarkerEvent(isMarker: false));
              }, 
              icon: Icon(Icons.adaptive.arrow_back_rounded)),
        ),
      ),
    );
  }
}

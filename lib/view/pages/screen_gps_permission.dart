import 'dart:developer';

import 'package:fastdrive/view_model/Bloc/gps/gps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenGpsPermission extends StatelessWidget {
  const ScreenGpsPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            log(state.toString());
            return !state.isLocationEnabled
             ?const _TurnOnLocation()
             :const _AskforGPSpermission();
          },
        ) 
      ),
    );
  }
}

class _TurnOnLocation extends StatelessWidget {
  const _TurnOnLocation();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Please turn on the Location.', 
      style: TextStyle( fontSize: 17),
      );
  }
}

class _AskforGPSpermission extends StatelessWidget {
  const _AskforGPSpermission();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const Text(
          "Before to continue provide GPS access",
          style: TextStyle(fontSize: 15)),
         MaterialButton(
          shape: const StadiumBorder(),
          color: Colors.black,
          child: const Text("Provide access", 
          style: TextStyle(
            color: Colors.white
          )
          ),
          onPressed: (){})
      ],
    );
  }
}
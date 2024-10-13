import 'package:fastdrive/view/pages/screens.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {

  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(create: (context) => MapBloc(locationBloc: context.read<LocationBloc>())),
      BlocProvider(create: (context) => BottomsheetBloc()),
      BlocProvider(create: (context) => SeacrhBloc()),
    ],
    child: const FastDriveApp(),
  ));
}

class FastDriveApp extends StatelessWidget {
  const FastDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenLoading()
    );
  }
}

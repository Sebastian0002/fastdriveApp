import 'package:fastdrive/view/pages/screens.dart';
import 'package:fastdrive/view_model/Bloc/gps/gps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc())
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

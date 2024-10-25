import 'package:animate_do/animate_do.dart';
import 'package:fastdrive/view/widgets/bottomsheet/map/map_bottomsheet.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({
    super.key,
  });

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  late bool openCompass;
  late bool isOffStage;

  final GlobalKey _key = GlobalKey();
  final GlobalKey _key1 = GlobalKey();
  double _widgetHeightMap = 50;
  double _widgetHeightCompass = 0;

  @override
  void initState() {
    openCompass = false;
    isOffStage = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
      final RenderBox renderBox1 = _key1.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _widgetHeightCompass = renderBox1.size.height;
        _widgetHeightMap = renderBox.size.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = context.read<MapBloc>();
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        openCompass = state.actualPosition?.bearing != 0;
        if(!openCompass){isOffStage = true;}

        return Positioned(
            top: 80,
            right: 10,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: !openCompass
                  ? _widgetHeightMap
                  : _widgetHeightMap + _widgetHeightCompass,
              onEnd: () =>
                setState(() => openCompass?isOffStage = false:null),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 3),
                        color: Colors.black54)
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    key: _key,
                    highlightColor: Colors.black12,
                    color: Colors.black,
                    icon: const Icon(Icons.map_rounded),
                    onPressed: () => mapModalSheet(context: context),
                  ),
                  Offstage(
                    offstage: isOffStage,
                    child: FadeIn(
                      child: Column(
                        key: _key1,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(color: Colors.black54, height: 0.5, width: 30),
                          IconButton(
                            highlightColor: Colors.black12,
                            color: Colors.black,
                            icon: const FaIcon(FontAwesomeIcons.compass),
                            onPressed: () {
                              mapBloc.focusNorth();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}

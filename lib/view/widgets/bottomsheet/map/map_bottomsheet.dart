import 'package:fastdrive/constants/map_list_style.dart';
import 'package:fastdrive/view/widgets/bottomsheet/map/card_map.dart';
import 'package:fastdrive/view_model/Bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> mapModalSheet({required BuildContext context}) async {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 0,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return SizedBox(
          width: double.infinity,
          height: size.height * 0.6,
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),
                SizedBox(height: 10),
                Expanded(child: _ListMap()),
              ],
            ),
          ),
        );
      });
}

class _ListMap extends StatelessWidget {
  const _ListMap();

  @override
  Widget build(BuildContext context) {
    final MapBloc mapBloc = context.read<MapBloc>();
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: listStyleMap.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  mapBloc.add(OnMapStyleChange(cardMapModelSelected: state.listCardMapModel[index]));
                },
                child: CardMap(cardMap: state.listCardMapModel[index]));
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Choose Map Style:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left),
        Container(
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(100)),
          child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(Icons.close_rounded),
              )),
        )
      ],
    );
  }
}

import 'package:fastdrive/data/models/models.dart';
import 'package:flutter/material.dart';


class CardMap extends StatelessWidget {
  const CardMap({super.key, required this.cardMap});

  final CardMapModel cardMap;

@override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final borderRadius = BorderRadius.circular(20);
  final width = (size.width * 0.40);
  final heigth = size.height * 0.18;
  return Container(
    margin: const EdgeInsets.all(10),
    height: heigth,
    width: width,
    decoration: BoxDecoration(
        border: cardMap.isSelected
            ? Border.all(color: Colors.blue, strokeAlign: 1, width: 2.5)
            : null,
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
              blurRadius: 2, offset: Offset(1, 3), color: Colors.black54)
        ]),
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
            borderRadius: borderRadius,
            child: Image.asset(
              cardMap.urlMap,
              fit: BoxFit.cover,
            )),
        Positioned(
            bottom: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              width: width,
              height: heigth * 0.18,
              child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  cardMap.nameMap,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
                  ))
      ],
    ),
  );
}
}

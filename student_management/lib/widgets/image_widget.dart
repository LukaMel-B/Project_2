import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageDisplay extends StatelessWidget {
  final ImageProvider<Object> image;
  InkWell pickMedia;
  ImageDisplay({Key? key, required this.image, required this.pickMedia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: image,
          radius: 70,
        ),
        Positioned(
          bottom: 6,
          right: 3,
          child: ClipOval(
            child: Container(
                height: 35,
                width: 35,
                color: Colors.teal[200],
                child: pickMedia),
          ),
        )
      ],
    );
  }
}

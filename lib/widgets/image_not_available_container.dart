import 'package:flutter/material.dart';

class ImageNAContainer extends StatelessWidget {
  const ImageNAContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      color: Colors.red,
      child: const Text(
        "Image not available",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
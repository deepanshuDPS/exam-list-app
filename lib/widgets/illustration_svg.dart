import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IllustrationSVG extends StatelessWidget {
  final String image;
  final BoxFit? fit;

  const IllustrationSVG({Key? key, required this.image, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: double.infinity,
      height: 250,
      fit: fit ?? BoxFit.fitHeight,
    );
  }
}

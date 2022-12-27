import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FadeInImageCustom extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const FadeInImageCustom(
      {super.key, required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
        width: width, height: height, image: CachedNetworkImageProvider(url));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luna/widgets/loading.dart';

class BuildImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const BuildImage({Key? key, required this.imageUrl, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => Loading(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luna/widgets/loading.dart';

class BuildImage extends StatelessWidget {
  final imageUrl;
  const BuildImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => Loading(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

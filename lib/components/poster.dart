import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../networks/api.dart';

class Poster extends StatelessWidget {
  String? posterPath;
  Poster({Key? key, required this.posterPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (posterPath == null) {
      return Image.asset(
        'assets/images/cover.png',
        height: 150,
        width: 100,
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImage(
      imageUrl: API.imageURL + posterPath!,
      placeholder: (context, url) => Image.asset(
        'assets/images/cover.png',
        height: 150,
        width: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}

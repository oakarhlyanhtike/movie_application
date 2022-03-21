import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../networks/api.dart';

class CastPic extends StatelessWidget {
  String? profilePath;
  CastPic({Key? key, required this.profilePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (profilePath == null) {
      return Image.asset(
        'assets/images/cast.png',
        height: 170,
        width: 230,
      );
    }

    return CachedNetworkImage(
      imageUrl: API.imageURL + profilePath!,
      placeholder: (context, url) => Image.asset(
        'assets/images/cast.png',
        height: 170,
        width: 230,
        fit: BoxFit.cover,
      ),
    );
  }
}

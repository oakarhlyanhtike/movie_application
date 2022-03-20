import 'dart:ui';

import 'package:flutter/material.dart';

import '../networks/api.dart';

class BlurBackGround extends StatelessWidget {
  var backdropPath;
  BlurBackGround({Key? key, required this.backdropPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(API.imageURL + backdropPath),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
          ),
        ));
  }
}

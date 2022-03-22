import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yote_shin_application/components/blur_background.dart';
import 'package:yote_shin_application/components/cast.dart';
import 'package:yote_shin_application/controller/detail_controller.dart';
import 'package:yote_shin_application/models/movie.dart';

import '../models/cast.dart';
import '../networks/api.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;
  String heroTag = '';
  DetailPage({Key? key, required this.movie, required this.heroTag})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = API();
  //List<Cast>? casts;
  final DeatilController d = Get.put(DeatilController());
  @override
  void initState() {
    d.loadCast(widget.movie.id);
    super.initState();
  }

  Widget _popularList() => d.casts.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : _castInformation();

  _movieInformation() => Padding(
        padding: const EdgeInsets.only(top: 100, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 120,
                    height: 150,
                    child: Card(
                        elevation: 8.0,
                        shadowColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Hero(
                          tag: widget.heroTag,
                          child: Image(
                            image: CachedNetworkImageProvider(
                              API.imageURL200 + widget.movie.posterPath!,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ))),
                const SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Text(
                        '${widget.movie.title} (${widget.movie.releaseDate!.year})',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text('${widget.movie.voteAverage}')
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Overview',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.black12,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.movie.overview,
                  ),
                )))
          ],
        ),
      );

  _castInformation() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Casts',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 260,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: d.casts.length,
                itemBuilder: (BuildContext context, index) {
                  Cast c = d.casts[index];
                  return SizedBox(
                    width: 125,
                    child: Card(
                      elevation: 7.0,
                      shadowColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          c.profilePath == null
                              ? Image.asset(
                                  'assets/images/cast.png',
                                  height: 180,
                                  width: 230,
                                  fit: BoxFit.cover,
                                )
                              : CastPic(profilePath: c.profilePath!),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              c.originalName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, top: 3.0),
                              child: Text(
                                c.character,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13.0,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(widget.movie.title),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Obx(() {
          return Stack(children: [
            widget.movie.backdropPath != null
                ? BlurBackGround(
                    backdropPath: widget.movie.backdropPath!,
                  )
                : const Center(
                    child: Text('Empty'),
                  ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _movieInformation(),
                  d.casts == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _castInformation()
                ],
              ),
            )
          ]);
        }));
  }
}

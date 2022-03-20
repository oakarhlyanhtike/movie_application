import 'package:flutter/material.dart';
import 'package:yote_shin_application/components/blur_background.dart';
import 'package:yote_shin_application/models/movie.dart';

import '../models/cast.dart';
import '../networks/api.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;
  DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = API();
  List<Cast>? casts;
  @override
  void initState() {
    api.getCast(widget.movie.id).then((value) {
      setState(() {
        casts = value;
      });
    });
    super.initState();
  }

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
                      child: Image.network(
                        API.imageURL200 + widget.movie.posterPath,
                        fit: BoxFit.fill,
                      ),
                    )),
                const SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 230,
                      child: Text(
                        '${widget.movie} (${widget.movie.releaseDate!.year})',
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

  _castInformation() => SizedBox(
        width: double.infinity,
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts!.length,
            itemBuilder: (BuildContext context, int index) {
              Cast c = casts![index];
              return (Column(
                children: [
                  Image.network(
                    API.imageURL + c.profilePath!,
                    width: 100,
                  )
                ],
              ));
            }),
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
        body: Stack(children: [
          BlurBackGround(
            backdropPath: widget.movie.backdropPath,
          ),
          Column(
            children: [
              _movieInformation(),
              casts == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _castInformation()
            ],
          )
        ]));
  }
}

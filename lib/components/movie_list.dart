import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yote_shin_application/models/movie.dart';
import 'package:yote_shin_application/networks/api.dart';
import 'package:yote_shin_application/pages/detail_page.dart';

class MovieList extends StatefulWidget {
  List<Movie> list;
  String title;
  MovieList({Key? key, required this.list, required this.title})
      : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 6, left: 8),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 240,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, index) {
                  Movie movie = widget.list[index];
                  print('Movie is $movie');
                  return InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    movie: movie,
                                    heroTag: '${movie.id}' + widget.title,
                                  )));
                    }),
                    child: SizedBox(
                      width: 125,
                      height: 230,
                      child: Card(
                        elevation: 3.0,
                        shadowColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 170,
                                  width: 220,
                                  child: Hero(
                                      tag: '${movie.id}' + widget.title,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            API.imageURL + movie.posterPath!,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/images/cover.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
                              Container(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 3),
                                width: double.infinity,
                                child: Text(
                                  '* ${movie.voteAverage}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.yellow.shade900,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text(
                                  '${movie.title}(${movie.releaseDate!.year})',
                                  maxLines: 2,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

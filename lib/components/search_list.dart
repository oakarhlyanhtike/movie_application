import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yote_shin_application/components/poster.dart';
import '../models/movie.dart';
import '../pages/detail_page.dart';

class SearchList extends StatefulWidget {
  List<Movie> list;

  SearchList({Key? key, required this.list}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        Movie m = widget.list[index];

        return InkWell(
          onTap: (() {
            Get.to(() => DetailPage(
                  movie: m,
                  heroTag: '${m.id}' + m.title,
                ));

           
          }),
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.black,
              elevation: 3.0,
              shadowColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 150,
                      child: Hero(
                          tag: '${m.id}' + m.title,
                          child: Poster(posterPath: m.posterPath))),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          m.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      m.releaseDate != null
                          ? Text(
                              '${m.releaseDate!.year}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          : const Text(''),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star),
                          Text(
                            '${m.voteAverage}',
                            style: const TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

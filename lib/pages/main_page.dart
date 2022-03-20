import 'package:flutter/material.dart';
import 'package:yote_shin_application/pages/search_page.dart';

import '../components/movie_list.dart';
import '../models/movie.dart';
import '../networks/api.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie>? popularMovies;
  List<Movie>? nowPlayingMovies;
  List<Movie>? trendingMovies;
  List<Movie>? upComingMovies;

  loadPopular() {
    API().getPopular().then((value) {
      setState(() {
        popularMovies = value;
      });
    });

    API().getNowPlaying().then((value) {
      setState(() {
        nowPlayingMovies = value;
      });
    });
    API().getTrendingMovies().then((value) {
      setState(() {
        trendingMovies = value;
      });
    });
    API().getUpcomingMovies().then((value) {
      setState(() {
        upComingMovies = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie App"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SearchPage()));
                  },
                  icon: const Icon(Icons.search)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            nowPlayingMovies == null
                ? const Center(child: CircularProgressIndicator())
                : MovieList(
                    list: nowPlayingMovies!,
                    title: "Now Playing",
                  ),
            popularMovies == null
                ? const Center(child: CircularProgressIndicator())
                : MovieList(
                    list: popularMovies!,
                    title: "Popular Movies",
                  ),
            trendingMovies == null
                ? const Center(child: CircularProgressIndicator())
                : MovieList(
                    list: trendingMovies!,
                    title: "Trending Movies",
                  ),
            upComingMovies == null
                ? const Center(child: CircularProgressIndicator())
                : MovieList(
                    list: upComingMovies!,
                    title: "UpComing Movies",
                  ),
          ]),
        ));
  }
}

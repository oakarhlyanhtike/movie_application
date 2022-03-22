import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yote_shin_application/controller/home_controller.dart';
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
  final HomeController c = Get.put(HomeController());
  // List<Movie>? popularMovies;
  // List<Movie>? nowPlayingMovies;
  // List<Movie>? trendingMovies;
  // List<Movie>? upComingMovies;

  // loadPopular() {
  //   API().getPopular().then((value) {
  //     setState(() {
  //       popularMovies = value;
  //     });
  //   });

  //   API().getNowPlaying().then((value) {
  //     setState(() {
  //       nowPlayingMovies = value;
  //     });
  //   });
  //   API().getTrendingMovies().then((value) {
  //     setState(() {
  //       trendingMovies = value;
  //     });
  //   });
  //   API().getUpcomingMovies().then((value) {
  //     setState(() {
  //       upComingMovies = value;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    c.loadPopular();
    c.loadNowPlaying();
    c.loadTrending();
    c.loadUpComing();
  }

  Widget _popularList() => c.popularMovies.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : MovieList(list: c.popularMovies, title: 'Popular Movies');
  Widget _nowPlayingList() => c.nowPlayingMovies.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : MovieList(list: c.nowPlayingMovies, title: 'NowPlaying Movies');
  Widget _trendingList() => c.trendingMovies.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : MovieList(list: c.trendingMovies, title: 'Trending Movies');
  Widget _upComingList() => c.upComingMovies.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : MovieList(list: c.upComingMovies, title: 'UpComing Movies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Application"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  icon: const Icon(Icons.search)),
            )
          ],
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(children: [
              _popularList(),
              _nowPlayingList(),
              _trendingList(),
              _upComingList(),
            ]),
          );
        }));
  }
}

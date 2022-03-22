import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../models/movie.dart';
import '../networks/api.dart';

class HomeController extends GetxController {
  RxList<Movie> popularMovies = <Movie>[].obs;
  RxList<Movie> nowPlayingMovies = <Movie>[].obs;
  RxList<Movie> trendingMovies = <Movie>[].obs;
  RxList<Movie> upComingMovies = <Movie>[].obs;

  loadPopular() {
    API().getPopular().then((value) {
      popularMovies.value = value;
    });
  }

  loadNowPlaying() {
    API().getNowPlaying().then((value) {
      nowPlayingMovies.value = value;
    });
  }
  loadTrending(){API().getTrendingMovies().then((value) {
      trendingMovies.value = value;
    });

  }

  loadUpComing(){API().getUpcomingMovies().then((value) {
      upComingMovies.value = value;
    });
    

  }

}

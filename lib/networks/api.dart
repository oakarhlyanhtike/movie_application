
import 'package:http/http.dart' as http;
import 'package:yote_shin_application/models/cast.dart';
import 'package:yote_shin_application/models/resp_cast.dart';

import '../models/movie.dart';
import '../models/res_popular.dart';

class API {
  final String _baseURL = "https://api.themoviedb.org/3";
  static const String imageURL = "https://image.tmdb.org/t/p/w500";
  static const String imageURL200 = "https://image.tmdb.org/t/p/w200";
  final String _apiKey = "a92f28e11a27e8e5938a2020be68ba9c";

  Future<List<Movie>> getList(String url, {String param = ""}) async {
    final response = await http.get(
      Uri.parse("$_baseURL$url?api_key=$_apiKey&$param"),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var resp = ResPopular.fromRawJson(response.body);
      return resp.results;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Movie>> getPopular() async {
    return getList("/movie/popular");
  }

  Future<List<Movie>> getNowPlaying() async {
    return getList("/movie/now_playing");
  }

  Future<List<Movie>> getTrendingMovies() {
    return getList("/trending/movie/week");
  }

  Future<List<Movie>> getUpcomingMovies() {
    return getList("/movie/upcoming");
  }

  Future<List<Movie>> getSearch(String name) async {
    return getList("/search/movie", param: "query=$name");
  }

  Future<List<Cast>> getCast(int movieId) async {
    var url = '/movie/$movieId/credits';
    final response = await http.get(
      Uri.parse("$_baseURL$url?api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var resp = RespCast.fromRawJson(response.body);
      return resp.cast;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }
 
}

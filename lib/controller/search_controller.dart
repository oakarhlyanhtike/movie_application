import 'package:get/get.dart';

import 'package:yote_shin_application/networks/api.dart';

import '../models/movie.dart';

import '../networks/api.dart';

class SearchController extends GetxController {

  RxList<Movie> res = <Movie>[].obs;


  loadSearch(String name) {
    API().getSearch(name).then((value) {
      res.value = value;
    });
  }
}

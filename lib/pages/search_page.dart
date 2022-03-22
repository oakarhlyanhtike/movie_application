import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yote_shin_application/components/search_list.dart';
import 'package:yote_shin_application/controller/search_controller.dart';
 
import 'package:yote_shin_application/networks/api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var movieApi = API();

  final SearchController c = Get.put(SearchController());

  Widget _search() => c.res.isEmpty
      ? const Center(
          child: Text('Please Search Movies')
        )
      : SearchList(list: c.res);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 50,
            child: TextField(
                textInputAction: TextInputAction.search,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),

                    // label: Text('Search Movie'),
                    hintText: 'Search Movie',
                    prefixIcon: const Icon(Icons.search),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    )),
                onSubmitted: (val) {
                  //  movieApi.getSearch(val).then((value) {
                  //   setState(() {
                  //     res = value;

                  //   });
                  // });

                  c.loadSearch(val);
                }),
          ),
        ),
        body: Obx(() {
          return 
              _search();
        }));
  }
}
// res == null
//             ? const Center(
//                 child: Text('Palese Search First'),
//               )
//             : SearchList(list: res!)

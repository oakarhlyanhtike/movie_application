import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

import '../models/cast.dart';
import '../networks/api.dart';

class DeatilController extends GetxController {
  RxList<Cast> casts = <Cast>[].obs;
  loadCast(int id){
     API().getCast(id).then((value) {
     
        casts.value = value;
    
    });

  }
}

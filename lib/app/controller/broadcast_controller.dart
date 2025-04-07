import 'package:get/get.dart';

import '../../main.dart';
import '../services/api_value.dart';
import '../utils/shared_pref_helper.dart';

class BroadcastController extends GetxController {
  RxList<dynamic> posterList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isTap = false.obs;
  RxList favouritePosters = [].obs;
  RxBool isFirstTime = true.obs;

  Future<void> initializePrefs() async {
    if (!isFirstTime.value) {
      posterList.value = box.get('posters') ?? [];
    } else {
      await initPosters();
    }
  }

  Future<void> initPosters() async {
    posterList.clear();
    isFirstTime.value = false;
    favouritePosters.value = box.get('favPosters') ?? [];
    isLoading.value = true;
    if (SharedPreferencesHelper.getIsLoggedIn()) {
      var posters = await apiValue.getPosters();
      if (posters != null) {
        Map<String, int> indicesMap = {};
        for (int i = 0; i < favouritePosters.length; i++) {
          indicesMap[favouritePosters[i]] = i;
        }
        posterList.value = posters;
        box.put("posters", posters);
        if (favouritePosters.isEmpty) {
          isLoading.value = false;
        } else {
          posterList.sort((a, b) {
            int indexA = indicesMap[a['_id']] ?? -1;
            int indexB = indicesMap[b['_id']] ?? -1;

            if (indexA != -1 && indexB == -1) {
              return -1;
            } else if (indexB != -1 && indexA == -1) {
              return 1;
            } else if (indexA != -1 && indexB != -1) {
              return indexA.compareTo(indexB);
            } else {
              return 0;
            }
          });
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
    }
  }
}

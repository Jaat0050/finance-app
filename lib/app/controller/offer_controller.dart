import 'package:get/get.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:mitra_fintech_agent/main.dart';

class OfferController extends GetxController {
  RxList<dynamic> offerList = [].obs;
  RxList<dynamic> offerLanguageList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isTap = false.obs;
  RxList favouriteOffer = [].obs;
  RxBool isFirstTime = true.obs;

  Future<void> initializePrefs() async {
    if (!isFirstTime.value) {
      offerList.value = box.get('offers') ?? [];
      offerLanguageList.value = box.get('offerLanguages') ?? [];
    } else {
      await initOffers();
    }
  }

  Future<void> initOffers() async {
    offerList.clear();
    offerLanguageList.clear();
    isFirstTime.value = false;
    favouriteOffer.value = box.get('favOffer') ?? [];
    isLoading.value = true;
    if (SharedPreferencesHelper.getIsLoggedIn()) {
      var offerLanguage = await apiValue.getOffersLanguage();
      if (offerLanguage != null) {
        offerLanguageList.addAll(offerLanguage);
        box.put("offerLanguages", offerLanguage);
      }
      var offer = await apiValue.getOffers();
      if (offer != null) {
        Map<String, int> indicesMap = {};
        for (int i = 0; i < favouriteOffer.length; i++) {
          indicesMap[favouriteOffer[i]] = i;
        }
        offerList.value = offer;
        box.put("offers", offer);
        if (favouriteOffer.isEmpty) {
          isLoading.value = false;
        } else {
          offerList.sort((a, b) {
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

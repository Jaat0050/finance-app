import 'package:get/get.dart';
import 'package:mitra_fintech_agent/main.dart';

import '../services/api_value.dart';

class LenderController extends GetxController {
  RxList<dynamic> lenderList = [].obs;
  RxList<dynamic> productList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isFirstTime = true.obs;

  Future<void> initializePrefs() async {
    if (!isFirstTime.value) {
      lenderList.value = box.get("lenderList") ?? [];
      productList.value = box.get("productList") ?? [];
    } else {
      await initLenders();
    }
  }

  Future<void> initLenders() async {
    lenderList.clear();
    productList.clear();

    isLoading.value = true;
    var response = await apiValue.getProductWiseLenders();

    if (response != null) {
      List productName = [];
      List lender = [];
      response.forEach((key, value) {
        productName.add(key);
        List lenders = value['lenders'];
        if (lenders != null && lenders.isNotEmpty) {
          lender.addAll(lenders);
        }
      });

      if (productName.isNotEmpty) {
        productList.addAll(productName);
        box.put("productList", productList.value);
      }

      if (lender.isNotEmpty) {
        lenderList.value = lender;
        box.put("lenderList", lenderList.value);
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
    }
    isFirstTime.value = false;
  }
}

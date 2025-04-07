import 'dart:developer';
import 'package:get/get.dart' hide Response;
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

class CommissionController extends GetxController {
  RxString commissionAmount = ''.obs;
  Future<void> getCommissionDetails() async {
    try {
      commissionAmount.value = SharedPreferencesHelper.getCommission();
      SharedPreferencesHelper.setCommission(
          commission: await apiValue.getCommission());

      commissionAmount.value = SharedPreferencesHelper.getCommission();

      // return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onInit() {
    getCommissionDetails();
    super.onInit();
  }
}

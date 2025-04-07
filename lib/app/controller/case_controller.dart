import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../services/api_value.dart';

class CaseController extends GetxController {
  RxList<dynamic> allLoanCases = [].obs;
  RxList<dynamic> filteredAllLoanCases = [].obs;

  RxList<dynamic> creditCardCases = [].obs;
  RxList<dynamic> filteredCreditCardCases = [].obs;

  RxBool isCaseLoading = true.obs;
  RxBool isFirstTime = true.obs;

  Future<void> initializePrefs() async {
    if (!isFirstTime.value) {
      allLoanCases.value = box.get('allLoanCases') ?? [];
      filteredAllLoanCases.value = allLoanCases.value;

      creditCardCases.value = box.get('creditCardCases') ?? [];
      filteredCreditCardCases.value = creditCardCases.value;
    } else {
      await initCases();
    }
  }

  Future<void> initCases() async {
    isCaseLoading.value = true;
    allLoanCases.clear();
    creditCardCases.clear();

    await initAllLoanCases();
    await initCreditCardCases();

    filteredAllLoanCases.value = allLoanCases.value;
    filteredCreditCardCases.value = creditCardCases.value;

    isCaseLoading.value = false;
    isFirstTime.value = false;
  }

  Future<void> initAllLoanCases() async {
    var casesData = await apiValue.getAllCases();
    if (casesData != null) {
      List<dynamic> cases = casesData.toList();
      allLoanCases.value = cases.where((element) => element != null).toList();

      // Sort allLoanCases in descending order
      allLoanCases.value.sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));

      box.put('allLoanCases', allLoanCases.value);
    }
  }

  Future<void> initCreditCardCases() async {
    var casesData = await apiValue.getCreditCardCases();
    if (casesData != null) {
      List<dynamic> cases = casesData.toList();
      creditCardCases.value =
          cases.where((element) => element != null).toList();

      // Sort creditCardCases in descending order
      creditCardCases.value.sort((a, b) => DateFormat("dd/MM/yyyy")
          .parse(b['LeadCreationDate'])
          .compareTo(DateFormat("dd/MM/yyyy").parse(a['LeadCreationDate'])));

      box.put('creditCardCases', creditCardCases.value);
    }
  }
}

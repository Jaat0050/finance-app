import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitra_fintech_agent/app/controller/case_controller.dart';

class FilterController extends GetxController {
  final caseController = Get.put(CaseController());

  RangeValues priceRange = const RangeValues(0, 20);
  double maxPrice = 0;
  // RangeValues percentRange = const RangeValues(0, 10);

  RxList<bool> applicationTypes =
      [false, false, false, false, false, false].obs;
  List<String> applicationTypeNames = [
    'Personal Loan',
    'Home/Mortgage Loan',
    'Car Loan',
    'Credit Card',
    'Business Loan',
    'Student Loan',
  ];
  RxList<bool> stateTypes = [false, false, false, false, false, false].obs;
  List<String> stateTypeNames = [
    'Applied', // createdAt
    'Pending', // caseStatus
    'Rejected', // rejectedAt
    'Processing', // sanctionedAt == null
    'Disbursement', // disbursedAt
    'Sanctions', // sanctionedAt
  ];

  void initpriceRange() {
    for (var caseItem in caseController.allLoanCases) {
      if (caseItem != null) {
        double agentCommission =
            double.parse(caseItem["agentCommission"].toString());
        if (agentCommission > maxPrice) {
          maxPrice = agentCommission;
        }
      }
    }
    priceRange = RangeValues(0, maxPrice);
  }

  void updateApplicationType(int index, bool newValue) {
    applicationTypes.value[index] = newValue;
  }

  void updateStateType(int index, bool newValue) {
    stateTypes.value[index] = newValue;
  }

  void clearFilters() {
    caseController.filteredAllLoanCases.value =
        List.from(caseController.allLoanCases);

    for (int i = 0; i < applicationTypes.length; i++) {
      applicationTypes[i] = false;
    }

    for (int i = 0; i < stateTypes.length; i++) {
      stateTypes[i] = false;
    }

    priceRange = RangeValues(0, maxPrice);
    // percentRange = const RangeValues(0, 10);
  }

  void applyFilter() {
    caseController.filteredAllLoanCases.clear();

    List<String> selectedApplicationTypes = [];
    for (int i = 0; i < applicationTypes.length; i++) {
      if (applicationTypes[i]) {
        selectedApplicationTypes.add(applicationTypeNames[i]);
      }
    }

    if (selectedApplicationTypes.isNotEmpty) {
      caseController.filteredAllLoanCases.addAll(caseController.allLoanCases
          .where((element) =>
              selectedApplicationTypes.contains(element["type"]) &&
              double.parse(element["agentCommission"].toString()) >=
                  priceRange.start.round() &&
              double.parse(element["agentCommission"].toString()) <=
                  priceRange.end.round()));
    } else {
      caseController.filteredAllLoanCases.addAll(caseController.allLoanCases
          .where((element) =>
              double.parse(element["agentCommission"].toString()) >=
                  priceRange.start.round() &&
              double.parse(element["agentCommission"].toString()) <=
                  priceRange.end.round()));
    }

    if (stateTypes.contains(true)) {
      List<dynamic> newFilteredCaseItems = [];
      for (int i = 0; i < stateTypes.length; i++) {
        if (stateTypes[i]) {
          switch (i) {
            case 0:
              newFilteredCaseItems.addAll(caseController.filteredAllLoanCases
                  .where((element) =>
                      element["createdAt"] != "" &&
                      element["createdAt"].toString() != "null" &&
                      element["caseStatusId"]["rejectedAt"].toString() ==
                          "null" &&
                      element["caseStatusId"]["disbursedAt"].toString() ==
                          "null" &&
                      element["caseStatusId"]["sanctionedAt"].toString() ==
                          "null"));
              break;
            case 1:
              newFilteredCaseItems.addAll(caseController.filteredAllLoanCases
                  .where((element) =>
                      element["caseStatusId"]["rejectedAt"].toString() ==
                          "null" &&
                      element["caseStatusId"]["disbursedAt"].toString() ==
                          "null" &&
                      element["caseStatusId"]["sanctionedAt"].toString() ==
                          "null" &&
                      element["caseStatus"].toString() == "PENDING"));
              break;
            case 2:
              newFilteredCaseItems.addAll(caseController.filteredAllLoanCases
                  .where((element) =>
                      element["caseStatusId"]["rejectedAt"].toString() !=
                      "null"));
              break;
            case 3:
              newFilteredCaseItems.addAll(caseController.filteredAllLoanCases
                  .where((element) =>
                      element["caseStatusId"]["rejectedAt"].toString() ==
                          "null" &&
                      element["caseStatusId"]["sanctionedAt"].toString() ==
                          "null"));
              break;
            case 4:
              newFilteredCaseItems.addAll(caseController.filteredAllLoanCases
                  .where((element) =>
                      element["caseStatusId"]["disbursedAt"].toString() !=
                      "null"));
              break;
            case 5:
              newFilteredCaseItems.addAll(caseController.filteredAllLoanCases
                  .where((element) =>
                      element["caseStatusId"]["sanctionedAt"].toString() !=
                      "null"));
              break;
          }
        }
      }
      caseController.filteredAllLoanCases.value = newFilteredCaseItems;
    }

    caseController.filteredAllLoanCases.refresh();
  }
}

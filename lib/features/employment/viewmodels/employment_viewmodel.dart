import 'package:flutter/material.dart';
import '../models/employment.dart';
import '../services/employ_api_service.dart';

class EmploymentViewModel extends ChangeNotifier {
  List<Employment> employmentList = [];
  bool isLoading = false;

  final EmploymentService _employmentService = EmploymentService();

  Future<void> fetchEmploymentList() async {
    isLoading = true;
    notifyListeners(); // 뷰에 데이터 갱신 요청

    try {
      employmentList = await _employmentService.fetchEmploymentList();
    } catch (e) {
      print('Error fetching employment data: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}

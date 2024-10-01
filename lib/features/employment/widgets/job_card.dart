import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onFavorite; // 즐겨찾기 콜백
  final bool isFavorite; // 즐겨찾기 상태

  JobCard({
    required this.job,
    required this.onFavorite,
    required this.isFavorite, // 즐겨찾기 상태를 받음
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(  // 스크롤 가능하도록 전체를 감쌈
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 즐겨찾기 아이콘 추가
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.star, // 즐겨찾기 아이콘을 별로 변경
                    color: isFavorite ? Colors.yellow : Colors.grey, // 즐겨찾기 여부에 따라 색상 변경
                  ),
                  onPressed: onFavorite, // 콜백 실행
                ),
              ),
              Text(
                job.infoTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.building, size: 14, color: Color(0xFF3498DB)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      job.companyName,
                      style: TextStyle(fontSize: 14, color: Color(0xFF34495E)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.moneyBill, size: 14, color: Color(0xFFF1C40F)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      job.wageType,
                      style: TextStyle(fontSize: 14, color: Color(0xFF34495E)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 14, color: Color(0xFFE74C3C)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      job.location,
                      style: TextStyle(fontSize: 14, color: Color(0xFF34495E)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.briefcase, size: 14, color: Color(0xFF2ECC71)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      job.careerCondition,
                      style: TextStyle(fontSize: 14, color: Color(0xFF34495E)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.userTie, size: 14, color: Color(0xFF9B59B6)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      job.employmentType,
                      style: TextStyle(fontSize: 14, color: Color(0xFF34495E)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

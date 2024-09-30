import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omniscient/features/employment/models/job.dart';
import 'job_detail_card.dart'; // JobDetail 임포트

class JobCard extends StatelessWidget {

  final Job job;

  JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // GestureDetector로 감싸기
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetail(jobId: job.webInfoUrl), // JobDetail로 이동
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 채용 정보 제목
                Text(
                  job.infoTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                SizedBox(height: 8),
                // 회사 이름
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.building, size: 14, color: Color(0xFF3498DB)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job.companyName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF34495E),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // 희망 임금
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.moneyBill, size: 14, color: Color(0xFFF1C40F)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job.wageType,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF34495E),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // 근무 위치
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 14, color: Color(0xFFE74C3C)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF34495E),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // 경력 조건
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.briefcase, size: 14, color: Color(0xFF2ECC71)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job.careerCondition,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF34495E),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // 고용 형태
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.userTie, size: 14, color: Color(0xFF9B59B6)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job.employmentType,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF34495E),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Font Awesome 사용
import '../models/test_job.dart';

class TestJobList extends StatelessWidget {
  final List<TestJob> testJobs;

  const TestJobList({Key? key, required this.testJobs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: testJobs.length,
      itemBuilder: (context, index) {
        final job = testJobs[index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 시험명
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendarDay, color: Colors.green), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('시험명: ${job.qualgbNm}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),

                // 설명
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.infoCircle, color: Colors.blue), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('설명: ${job.description}'),
                  ],
                ),
                SizedBox(height: 8),

                // 문서 등록 기간
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendarAlt, color: Colors.orange), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('문서 등록 기간: ${job.docRegStartDt} ~ ${job.docRegEndDt}'),
                  ],
                ),
                SizedBox(height: 8),

                // 문서 시험 기간
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendarCheck, color: Colors.red), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('문서 시험 기간: ${job.docExamStartDt} ~ ${job.docExamEndDt}'),
                  ],
                ),
                SizedBox(height: 8),

                // 문서 합격일
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendarDay, color: Colors.lightGreen), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('문서 합격일: ${job.docPassDt}'),
                  ],
                ),
                SizedBox(height: 8),

                // 실기 등록 기간
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendarDay, color: Colors.teal), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('실기 등록 기간: ${job.pracRegStartDt} ~ ${job.pracRegEndDt}'),
                  ],
                ),
                SizedBox(height: 8),

                // 실기 시험 기간
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendarCheck, color: Colors.purple), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('실기 시험 기간: ${job.pracExamStartDt} ~ ${job.pracExamEndDt}'),
                  ],
                ),
                SizedBox(height: 8),

                // 실기 합격일
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendarDay, color: Colors.redAccent), // 아이콘 추가
                    SizedBox(width: 8),
                    Text('실기 합격일: ${job.pracPassDt}'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

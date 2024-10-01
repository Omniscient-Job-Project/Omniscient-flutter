import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Font Awesome 사용
import '../models/test_job.dart';

class TestJobList extends StatelessWidget {
  final List<TestJob> testJobs;
  final Function(TestJob)? onFavoritePressed; // 즐겨찾기 기능을 위한 콜백 함수 (선택적)
  final Function(TestJob)? onRemove; // 삭제를 위한 콜백 함수 (선택적)
  final bool isFavorite; // 즐겨찾기 여부

  const TestJobList({
    Key? key,
    required this.testJobs,
    this.onFavoritePressed,
    this.onRemove,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // 부모의 제약을 받도록 설정
      physics: NeverScrollableScrollPhysics(), // 내부 스크롤 비활성화
      itemCount: testJobs.length,
      itemBuilder: (context, index) {
        final job = testJobs[index];
        return Stack(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 시험명
                    _buildInfoRow(
                      FontAwesomeIcons.calendarDay,
                      Colors.green,
                      '시험명: ${job.qualgbNm}',
                      isBold: true,
                      fontSize: 18,
                    ),
                    SizedBox(height: 8),

                    // 설명
                    _buildInfoRow(
                      FontAwesomeIcons.infoCircle,
                      Colors.blue,
                      '설명: ${job.description}',
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),

                    // 문서 등록 기간
                    _buildInfoRow(
                      FontAwesomeIcons.calendarAlt,
                      Colors.orange,
                      '문서 등록 기간: ${job.docRegStartDt} ~ ${job.docRegEndDt}',
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),

                    // 문서 시험 기간
                    _buildInfoRow(
                      FontAwesomeIcons.calendarCheck,
                      Colors.red,
                      '문서 시험 기간: ${job.docExamStartDt} ~ ${job.docExamEndDt}',
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),

                    // 문서 합격일
                    _buildInfoRow(
                      FontAwesomeIcons.calendarDay,
                      Colors.lightGreen,
                      '문서 합격일: ${job.docPassDt}',
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),

                    // 실기 등록 기간
                    _buildInfoRow(
                      FontAwesomeIcons.calendarDay,
                      Colors.teal,
                      '실기 등록 기간: ${job.pracRegStartDt} ~ ${job.pracRegEndDt}',
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),

                    // 실기 시험 기간
                    _buildInfoRow(
                      FontAwesomeIcons.calendarCheck,
                      Colors.purple,
                      '실기 시험 기간: ${job.pracExamStartDt} ~ ${job.pracExamEndDt}',
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),

                    // 실기 합격일
                    _buildInfoRow(
                      FontAwesomeIcons.calendarDay,
                      Colors.redAccent,
                      '실기 합격일: ${job.pracPassDt}',
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            // 즐겨찾기 버튼을 오른쪽 상단에 배치
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.yellow : null,
                ),
                onPressed: () => onFavoritePressed!(job),
              ),
            ),
            // 삭제 버튼을 오른쪽 하단에 배치
            if (onRemove != null)
              Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onRemove!(job),
                ),
              ),
          ],
        );
      },
    );
  }

  // 정보 행을 생성하는 헬퍼 메서드
  Widget _buildInfoRow(IconData icon, Color color, String text, {bool isBold = false, double fontSize = 16}) {
    return Row(
      children: [
        FaIcon(icon, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

// models/test_job.dart
class TestJob {
  final String qualgbNm; // 시험명
  final String description; // 설명
  final String docRegStartDt; // 문서 등록 시작일
  final String docRegEndDt; // 문서 등록 종료일
  final String docExamStartDt; // 문서 시험 시작일
  final String docExamEndDt; // 문서 시험 종료일
  final String docPassDt; // 문서 합격일
  final String pracRegStartDt; // 실기 등록 시작일
  final String pracRegEndDt; // 실기 등록 종료일
  final String pracExamStartDt; // 실기 시험 시작일
  final String pracExamEndDt; // 실기 시험 종료일
  final String pracPassDt; // 실기 합격일

  TestJob({
    required this.qualgbNm,
    required this.description,
    required this.docRegStartDt,
    required this.docRegEndDt,
    required this.docExamStartDt,
    required this.docExamEndDt,
    required this.docPassDt,
    required this.pracRegStartDt,
    required this.pracRegEndDt,
    required this.pracExamStartDt,
    required this.pracExamEndDt,
    required this.pracPassDt,
  });

  factory TestJob.fromJson(Map<String, dynamic> json) {
    return TestJob(
      qualgbNm: json['qualgbNm']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      docRegStartDt: json['docRegStartDt']?.toString() ?? '',
      docRegEndDt: json['docRegEndDt']?.toString() ?? '',
      docExamStartDt: json['docExamStartDt']?.toString() ?? '',
      docExamEndDt: json['docExamEndDt']?.toString() ?? '',
      docPassDt: json['docPassDt']?.toString() ?? '',
      pracRegStartDt: json['pracRegStartDt']?.toString() ?? '',
      pracRegEndDt: json['pracRegEndDt']?.toString() ?? '',
      pracExamStartDt: json['pracExamStartDt']?.toString() ?? '',
      pracExamEndDt: json['pracExamEndDt']?.toString() ?? '',
      pracPassDt: json['pracPassDt']?.toString() ?? '',
    );
  }
}

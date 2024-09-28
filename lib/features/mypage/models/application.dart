class Application {
  final int id;
  final String companyName;
  final String companyLogo;
  final String position;
  final DateTime applicationDate;
  final String status;
  final String jobDescription;
  final List<String> requirements;
  final List<String> applicationProcess;
  final int currentStep;

  Application({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.position,
    required this.applicationDate,
    required this.status,
    required this.jobDescription,
    required this.requirements,
    required this.applicationProcess,
    required this.currentStep,
  });

  // 날짜 형식 변환
  String formatDate() {
    return "${applicationDate.year}-${applicationDate.month.toString().padLeft(2, '0')}-${applicationDate.day.toString().padLeft(2, '0')}";
  }

  // 지원 상태를 텍스트로 변환
  String getStatusText() {
    switch (status) {
      case 'IN_REVIEW':
        return '서류 심사 중';
      case 'PASSED':
        return '서류 통과';
      case 'REJECTED':
        return '불합격';
      default:
        return status;
    }
  }
}

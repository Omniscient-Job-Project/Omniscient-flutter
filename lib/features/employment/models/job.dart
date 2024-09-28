class Job {
  final String companyName;      // 회사 이름
  final String infoTitle;        // 채용 정보 제목
  final String wageType;         // 급여 형태
  final String salary;           // 급여 금액
  final String location;         // 근무 위치
  final String employmentType;   // 고용 형태
  final String careerCondition;  // 경력 조건
  final String webInfoUrl;       // 웹에서 공고를 볼 수 있는 URL
  final String mobileInfoUrl;    // 모바일에서 공고를 볼 수 있는 URL

  // 생성자
  Job({
    required this.companyName,
    required this.infoTitle,
    required this.wageType,
    required this.salary,
    required this.location,
    required this.employmentType,
    required this.careerCondition,
    required this.webInfoUrl,
    required this.mobileInfoUrl,
  });

  // JSON 데이터를 Dart 객체로 변환하는 팩토리 메서드
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      companyName: json['MNGR_INSTT_NM'] ?? '', // 회사 이름
      infoTitle: json['JOBCODE_NM'] ?? '',     // 채용 정보 제목
      wageType: json['HOPE_WAGE'] ?? '',        // 급여 형태
      salary: json['HOPE_WAGE'] ?? '',          // 급여 금액
      location: json['SUBWAY_NM'] ?? '',       // 근무 위치
      employmentType: json['EMPLYM_STLE_CMMN_MM'] ?? '', // 고용 형태
      careerCondition: json['CAREER_CND_NM'] ?? '', // 경력 조건
      webInfoUrl: '',  // 웹 정보 URL (API에 없으므로 빈 문자열)
      mobileInfoUrl: '', // 모바일 정보 URL (API에 없으므로 빈 문자열)
    );
  }

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'infoTitle': infoTitle,
      'wageType': wageType,
      'salary': salary,
      'location': location,
      'employmentType': employmentType,
      'careerCondition': careerCondition,
      'webInfoUrl': webInfoUrl,
      'mobileInfoUrl': mobileInfoUrl,
    };
  }
}

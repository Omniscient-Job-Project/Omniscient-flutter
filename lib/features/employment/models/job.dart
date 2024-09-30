class Job {
  final String id;  // Add this line
  final String companyName;
  final String infoTitle;
  final String wageType;
  final String salary;
  final String location;
  final String employmentType;
  final String careerCondition;
  final String webInfoUrl;
  final String mobileInfoUrl;

  // Constructor
  Job({
    required this.id,  // Add this line
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

  // JSON parsing
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['jobId'] ?? '',  // Map jobId to id
      companyName: json['MNGR_INSTT_NM'] ?? '정보 없음',
      infoTitle: json['JOBCODE_NM'] ?? '제목 없음',
      wageType: json['WAGE_TYPE'] ?? '정보 없음',
      salary: json['HOPE_WAGE'] ?? '정보 없음',
      location: json['SUBWAY_NM'] ?? '정보 없음',
      employmentType: json['EMPLYM_STLE_CMMN_MM'] ?? '정보 없음',
      careerCondition: json['CAREER_CND_NM'] ?? '정보 없음',
      webInfoUrl: json['WEB_INFO_URL'] ?? '',
      mobileInfoUrl: json['MOBILE_INFO_URL'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobId': id,  // Add this line
      'MNGR_INSTT_NM': companyName,
      'JOBCODE_NM': infoTitle,
      'WAGE_TYPE': wageType,
      'HOPE_WAGE': salary,
      'SUBWAY_NM': location,
      'EMPLYM_STLE_CMMN_MM': employmentType,
      'CAREER_CND_NM': careerCondition,
      'WEB_INFO_URL': webInfoUrl,
      'MOBILE_INFO_URL': mobileInfoUrl,
    };
  }
}

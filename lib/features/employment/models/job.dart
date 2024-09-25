class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String career;
  final String salary;
  final String employmentType;
  final String webInfoUrl;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.career,
    required this.salary,
    required this.employmentType,
    required this.webInfoUrl,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['ENTRPRS_NM'] ?? '',
      title: json['PBANC_CONT'] ?? '',
      company: json['ENTRPRS_NM'] ?? '',
      location: json['WORK_REGION_CONT'] ?? '',
      career: json['CAREER_DIV'] ?? '',
      salary: json['SALARY_COND'] ?? '',
      employmentType: json['PBANC_FORM_DIV'] ?? '',
      webInfoUrl: json['URL'] ?? '',
    );
  }
}
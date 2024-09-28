class Resume {
  String title;
  String skills;
  String introduction;

  Resume({
    required this.title,
    required this.skills,
    required this.introduction,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      title: json['title'],
      skills: json['skills'],
      introduction: json['introduction'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'skills': skills,
    'introduction': introduction,
  };
}

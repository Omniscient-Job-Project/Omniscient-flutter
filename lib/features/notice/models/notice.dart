class Notice {
  final int noticeId;
  final String noticeTitle;
  final String noticeCreateAt;
  final int noticeViews;
  final bool noticeStatus;
  final int displayId;
  final String noticeContent;

  Notice({
    required this.noticeId,
    required this.noticeTitle,
    required this.noticeCreateAt,
    required this.noticeViews,
    required this.noticeStatus,
    required this.displayId,
    required this.noticeContent,
  });

  // fromJson 생성자
  factory Notice.fromJson(Map<String, dynamic> json, int displayId) {
    return Notice(
      noticeId: json['noticeId'],
      noticeTitle: json['noticeTitle'],
      noticeCreateAt: json['noticeCreateAt'],
      noticeViews: json['noticeViews'],
      noticeStatus: json['noticeStatus'],
      displayId: displayId,
      noticeContent: json['noticeContent'] ?? '',
    );
  }

  // copyWith 메서드 추가
  Notice copyWith({
    int? noticeId,
    String? noticeTitle,
    String? noticeCreateAt,
    int? noticeViews,
    bool? noticeStatus,
    int? displayId,
    String? noticeContent,
  }) {
    return Notice(
      noticeId: noticeId ?? this.noticeId,
      noticeTitle: noticeTitle ?? this.noticeTitle,
      noticeCreateAt: noticeCreateAt ?? this.noticeCreateAt,
      noticeViews: noticeViews ?? this.noticeViews,
      noticeStatus: noticeStatus ?? this.noticeStatus,
      displayId: displayId ?? this.displayId,
      noticeContent: noticeContent ?? this.noticeContent,
    );
  }
}

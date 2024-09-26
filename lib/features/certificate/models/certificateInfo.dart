class CertificateInfo {
  final String jmNm; // 자격증 이름
  final String instiNm; // 기관 이름
  final String grdNm; // 등급
  final double preyyAcquQualIncRate; // 자격증 취득률
  final int preyyQualAcquCnt; // 전년도 자격증 취득 수
  final int qualAcquCnt; // 총 자격증 취득 수
  final int statisYy; // 통계 연도 (int로 변경)
  final int sumYy; // 합계 연도 (int로 변경)

  CertificateInfo({
    required this.jmNm,
    required this.instiNm,
    required this.grdNm,
    required this.preyyAcquQualIncRate,
    required this.preyyQualAcquCnt,
    required this.qualAcquCnt,
    required this.statisYy,
    required this.sumYy,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory CertificateInfo.fromJson(Map<String, dynamic> json) {
    return CertificateInfo(
      jmNm: json['jmNm'] ?? '',
      instiNm: json['instiNm'] ?? '',
      grdNm: json['grdNm'] ?? '',
      preyyAcquQualIncRate: _parseToDouble(json['preyyAcquQualIncRate']),
      preyyQualAcquCnt: _parseToInt(json['preyyQualAcquCnt']),
      qualAcquCnt: _parseToInt(json['qualAcquCnt']),
      statisYy: _parseToInt(json['statisYy']), // 타입 변환 함수 사용
      sumYy: _parseToInt(json['sumYy']),       // 타입 변환 함수 사용
    );
  }

  // double로 변환하는 함수
  static double _parseToDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      return double.tryParse(value.toString()) ?? 0.0;
    }
  }

  // int로 변환하는 함수
  static int _parseToInt(dynamic value) {
    if (value == null) {
      return 0;
    } else if (value is int) {
      return value;
    } else {
      return int.tryParse(value.toString()) ?? 0;
    }
  }
}

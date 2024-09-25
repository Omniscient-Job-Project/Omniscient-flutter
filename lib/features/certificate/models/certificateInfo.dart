class CertificateInfo {
  final String jmNm; // 자격증 이름
  final String instiNm; // 기관 이름
  final String grdNm; // 등급
  final double preyyAcquQualIncRate; // 자격증 취득률
  final int preyyQualAcquCnt; // 전년도 자격증 취득 수
  final int qualAcquCnt; // 총 자격증 취득 수
  final String statisYy; // 통계 연도
  final String sumYy; // 합계 연도

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
      jmNm: json['jmNm'],
      instiNm: json['instiNm'],
      grdNm: json['grdNm'],
      preyyAcquQualIncRate: json['preyyAcquQualIncRate']?.toDouble() ?? 0.0,
      preyyQualAcquCnt: json['preyyQualAcquCnt'] ?? 0,
      qualAcquCnt: json['qualAcquCnt'] ?? 0,
      statisYy: json['statisYy'] ?? '',
      sumYy: json['sumYy'] ?? '',
    );
  }
}

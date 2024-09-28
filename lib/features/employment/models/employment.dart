class Employment {
  // id 필드 제거
  final String divNm;
  final String regionNm;
  final String instNm;
  final String contctNm;
  final String? hmpgNm; // null 가능성 추가
  final String refineRoadnmAddr;
  final String refineLotnoAddr;
  final String refineZipNo;
  final double refineWgs84Lat; // double로 변경
  final double refineWgs84Logt; // double로 변경

  Employment({
    required this.divNm,
    required this.regionNm,
    required this.instNm,
    required this.contctNm,
    this.hmpgNm,
    required this.refineRoadnmAddr,
    required this.refineLotnoAddr,
    required this.refineZipNo,
    required this.refineWgs84Lat,
    required this.refineWgs84Logt,
  });

  factory Employment.fromJson(Map<String, dynamic> json) {
    return Employment(
      divNm: json['DIV_NM'] ?? '',  // API 키와 맞추기
      regionNm: json['REGION_NM'] ?? '',  // API 키와 맞추기
      instNm: json['INST_NM'] ?? '',  // API 키와 맞추기
      contctNm: json['CONTCT_NM'] ?? '',  // API 키와 맞추기
      hmpgNm: json['HMPG_NM'], // null 가능성 반영
      refineRoadnmAddr: json['REFINE_ROADNM_ADDR'] ?? '', // API 키와 맞추기
      refineLotnoAddr: json['REFINE_LOTNO_ADDR'] ?? '', // API 키와 맞추기
      refineZipNo: json['REFINE_ZIPNO']?.toString() ?? '', // String으로 변환
      refineWgs84Lat: _toDouble(json['REFINE_WGS84_LAT']), // API 키와 맞추기
      refineWgs84Logt: _toDouble(json['REFINE_WGS84_LOGT']), // API 키와 맞추기
    );
  }

  static double _toDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    }
    return 0.0;
  }
}

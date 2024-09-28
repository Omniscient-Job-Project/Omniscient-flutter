class Employment {
  final int id;
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
    required this.id,
    required this.divNm,
    required this.regionNm,
    required this.instNm,
    required this.contctNm,
    this.hmpgNm, // null 가능성 추가
    required this.refineRoadnmAddr,
    required this.refineLotnoAddr,
    required this.refineZipNo,
    required this.refineWgs84Lat,
    required this.refineWgs84Logt,
  });

  factory Employment.fromJson(Map<String, dynamic> json) {
    return Employment(
      id: _toInt(json['id']),
      divNm: json['divNm'],
      regionNm: json['regionNm'],
      instNm: json['instNm'],
      contctNm: json['contctNm'],
      hmpgNm: json['hmpgNm'], // null 가능성 반영
      refineRoadnmAddr: json['refineRoadnmAddr'],
      refineLotnoAddr: json['refineLotnoAddr'],
      refineZipNo: json['refineZipNo'],
      refineWgs84Lat: _toDouble(json['refineWgs84Lat']),
      refineWgs84Logt: _toDouble(json['refineWgs84Logt']),
    );
  }

  // int 변환 함수
  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0; // 변환 실패 시 0 반환
    } else {
      return 0; // 다른 타입일 경우 0으로 반환
    }
  }

  // double 변환 함수
  static double _toDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0; // 변환 실패 시 0.0 반환
    } else if (value is int) {
      return value.toDouble(); // int인 경우 double로 변환
    } else {
      return 0.0; // 다른 타입일 경우 0.0 반환
    }
  }
}

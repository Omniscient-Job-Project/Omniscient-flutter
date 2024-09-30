class Employment {
  final String divNm;               // Division Name
  final String regionNm;            // Region Name
  final String instNm;              // Institution Name
  final String contctNm;            // Contact Name
  final String? hmpgNm;             // Homepage Name (nullable)
  final String refineRoadnmAddr;    // Refined Road Address
  final String refineLotnoAddr;     // Refined Lot Address
  final String refineZipNo;         // Refined Zip Code
  final double refineWgs84Lat;      // Latitude
  final double refineWgs84Logt;     // Longitude
  final String? jmNm;               // Job Name (nullable)
  final String? grdNm;              // Grade Name (nullable)

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
    this.jmNm,
    this.grdNm,
  });

  factory Employment.fromJson(Map<String, dynamic> json) {
    return Employment(
      divNm: json['DIV_NM'] ?? '',
      regionNm: json['REGION_NM'] ?? '',
      instNm: json['INST_NM'] ?? '',  // Ensure this line is present
      contctNm: json['CONTCT_NM'] ?? '',
      hmpgNm: json['HMPG_NM'], // nullable
      refineRoadnmAddr: json['REFINE_ROADNM_ADDR'] ?? '',
      refineLotnoAddr: json['REFINE_LOTNO_ADDR'] ?? '',
      refineZipNo: json['REFINE_ZIPNO']?.toString() ?? '',
      refineWgs84Lat: _toDouble(json['REFINE_WGS84_LAT']),
      refineWgs84Logt: _toDouble(json['REFINE_WGS84_LOGT']),
      jmNm: json['JM_NM'], // Add this line to get jmNm from JSON
      grdNm: json['GRD_NM'], // Add this line to get grdNm from JSON
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

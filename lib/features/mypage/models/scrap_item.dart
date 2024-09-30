class ScrapItem {
  final String? jobId; // Job ID
  final String? jobInfoTitle; // Job title
  final String? jobCompanyName; // Company name for the job
  final String? jobLocation; // Job location
  final String? jobCareerCondition; // Career condition for the job
  final String? jmNm; // Job name for employment
  final String? instiNm; // Institution name for employment
  final String? grdNm; // Grade name for employment
  final int? preyyAcquQualIncRate; // Qualification acquisition rate for employment
  final int? preyyQualAcquCnt; // Qualification count for previous year
  final int? qualAcquCnt; // Total qualification count
  final String? statisYy; // Statistical year
  final String? sumYy; // Sum year
  final String? instNm; // Institution name (general)
  final String? contctNm; // Contact name (general)
  final String? refineLotnoAddr; // Refined lot number address
  final String? refineZipNo; // Refined zip number
  final String? regionNm; // Region name

  ScrapItem({
    this.jobId,
    this.jobInfoTitle,
    this.jobCompanyName,
    this.jobLocation,
    this.jobCareerCondition,
    this.jmNm,
    this.instiNm,
    this.grdNm,
    this.preyyAcquQualIncRate,
    this.preyyQualAcquCnt,
    this.qualAcquCnt,
    this.statisYy,
    this.sumYy,
    this.instNm,
    this.contctNm,
    this.refineLotnoAddr,
    this.refineZipNo,
    this.regionNm,
  });

  factory ScrapItem.fromJson(Map<String, dynamic> json) {
    return ScrapItem(
      jobId: json['jobId'],
      jobInfoTitle: json['jobInfoTitle'],
      jobCompanyName: json['jobCompanyName'],
      jobLocation: json['jobLocation'],
      jobCareerCondition: json['jobCareerCondition'],
      jmNm: json['jmNm'],
      instiNm: json['instiNm'],
      grdNm: json['grdNm'],
      preyyAcquQualIncRate: json['preyyAcquQualIncRate'],
      preyyQualAcquCnt: json['preyyQualAcquCnt'],
      qualAcquCnt: json['qualAcquCnt'],
      statisYy: json['statisYy'],
      sumYy: json['sumYy'],
      instNm: json['instNm'],
      contctNm: json['contctNm'],
      refineLotnoAddr: json['refineLotnoAddr'],
      refineZipNo: json['refineZipNo'],
      regionNm: json['regionNm'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'jobInfoTitle': jobInfoTitle,
      'jobCompanyName': jobCompanyName,
      'jobLocation': jobLocation,
      'jobCareerCondition': jobCareerCondition,
      'jmNm': jmNm,
      'instiNm': instiNm,
      'grdNm': grdNm,
      'preyyAcquQualIncRate': preyyAcquQualIncRate,
      'preyyQualAcquCnt': preyyQualAcquCnt,
      'qualAcquCnt': qualAcquCnt,
      'statisYy': statisYy,
      'sumYy': sumYy,
      'instNm': instNm,
      'contctNm': contctNm,
      'refineLotnoAddr': refineLotnoAddr,
      'refineZipNo': refineZipNo,
      'regionNm': regionNm,
    };
  }
}

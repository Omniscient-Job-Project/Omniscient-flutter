class ScrapItem {
  final String? jobId;
  final String? jobInfoTitle;
  final String? jobCompanyName;
  final String? jobLocation;
  final String? jobCareerCondition;
  final String? jmNm;
  final String? instiNm;
  final String? grdNm;
  final int? preyyAcquQualIncRate;
  final int? preyyQualAcquCnt;
  final int? qualAcquCnt;
  final String? statisYy;
  final String? sumYy;  // sumYy 필드 추가
  final String? instNm;
  final String? contctNm;
  final String? refineLotnoAddr;
  final String? refineZipNo;
  final String? regionNm;

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
    this.sumYy,  // sumYy 필드 추가
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
      sumYy: json['sumYy'],  // sumYy 추가
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
      'sumYy': sumYy,  // sumYy 추가
      'instNm': instNm,
      'contctNm': contctNm,
      'refineLotnoAddr': refineLotnoAddr,
      'refineZipNo': refineZipNo,
      'regionNm': regionNm,
    };
  }
}

import 'package:flutter/material.dart';
import '../models/scrap_item.dart';

class ScrapItemCard extends StatelessWidget {
  final ScrapItem scrapItem;
  final VoidCallback onRemove;

  const ScrapItemCard({
    Key? key,
    required this.scrapItem,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 자격증 이름 또는 직무 제목 표시
            Text(
              scrapItem.jobInfoTitle ?? scrapItem.jmNm ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 회사 이름 또는 기관 이름 표시
            if (scrapItem.jobCompanyName != null)
              Text('회사: ${scrapItem.jobCompanyName}'),
            if (scrapItem.instiNm != null)
              Text('기관: ${scrapItem.instiNm}'),

            // 위치 정보 또는 주소 표시
            if (scrapItem.jobLocation != null)
              Text('위치: ${scrapItem.jobLocation}'),
            if (scrapItem.refineLotnoAddr != null)
              Text('주소: ${scrapItem.refineLotnoAddr}'),
            if (scrapItem.refineZipNo != null)
              Text('우편번호: ${scrapItem.refineZipNo}'),

            // 경력 또는 자격증 관련 정보 표시
            if (scrapItem.jobCareerCondition != null)
              Text('경력: ${scrapItem.jobCareerCondition}'),
            if (scrapItem.preyyAcquQualIncRate != null)
              Text('자격증 취득률: ${scrapItem.preyyAcquQualIncRate}%'),
            if (scrapItem.qualAcquCnt != null)
              Text('총 자격증 취득 수: ${scrapItem.qualAcquCnt}'),

            // 연락처 및 기타 정보 표시
            if (scrapItem.contctNm != null)
              Text('연락처: ${scrapItem.contctNm}'),
            if (scrapItem.regionNm != null)
              Text('지역: ${scrapItem.regionNm}'),

            // 기타 추가 정보 표시
            if (scrapItem.grdNm != null)
              Text('등급: ${scrapItem.grdNm}'),
            if (scrapItem.preyyQualAcquCnt != null)
              Text('전년도 자격증 취득 수: ${scrapItem.preyyQualAcquCnt}'),
            if (scrapItem.statisYy != null)
              Text('통계 연도: ${scrapItem.statisYy}'),
            if (scrapItem.sumYy != null)
              Text('합계 연도: ${scrapItem.sumYy}'),

            // 삭제 버튼
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

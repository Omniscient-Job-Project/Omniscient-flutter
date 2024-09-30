import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 임포트

class JobDetail extends StatefulWidget {
  final String jobId;

  JobDetail({required this.jobId});

  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  Map<String, dynamic>? jobDetail;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    fetchJobData();
    checkIfBookmarked();
  }

  Future<void> fetchJobData() async {
    final String apiUrl = '${dotenv.env['API_URL']}/api/v1/seoul/jobinfo/${widget.jobId}';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['JO_REQST_NO'] != null) {
          setState(() {
            jobDetail = transformSeoulData(data);
          });
        } else {
          throw Exception('알 수 없는 API 응답 형식입니다.');
        }
      } else {
        throw Exception('잡 정보를 가져오는 데 실패했습니다.');
      }
    } catch (error) {
      print('세부 정보를 가져오는 데 실패했습니다: $error');
    }
  }

  Map<String, dynamic> transformSeoulData(Map<String, dynamic> data) {
    return {
      'companyName': data['CMPNY_NM'],
      'title': data['JO_SJ'],
      'receiptPeriod': '${data['JO_REG_DT']} ~ ${data['RCEPT_CLOS_NM']}',
      'description': data['GUI_LN'] ?? '정보 없음',
      'summary': data['BSNS_SUMRY_CN'] ?? '정보 없음',
      'employmentType': data['EMPLYM_STLE_CMMN_MM'] ?? '정보 없음',
      'experience': data['CAREER_CND_NM'] ?? '정보 없음',
      'education': data['ACDMCR_NM'] ?? '정보 없음',
      'field': data['JOBCODE_NM'] ?? '정보 없음',
      'workDays': data['HOLIDAY_NM'] ?? '정보 없음',
      'workHours': '${data['WORK_TM_NM']}, ${data['WORK_TIME_NM']}' ?? '정보 없음',
      'salary': data['HOPE_WAGE'] ?? '정보 없음',
      'location': data['BASS_ADRES_CN'] ?? '정보 없음',
      'applyUrl': data['jobWebInfoUrl'] ?? '정보 없음',
      'companyLocation': data['WORK_PARAR_BASS_ADRES_CN'] ?? '정보 없음',
      'companyPhone': data['MNGR_PHON_NO'] ?? '정보 없음',
      'contactPerson': data['MNGR_NM'] ?? '정보 없음',
    };
  }

  void checkIfBookmarked() {
    // 북마크 확인 로직
  }

  void toggleBookmark() {
    // 북마크 토글 로직
  }

  void addToBookmarks() {
    // 북마크 추가 로직
  }

  void removeFromBookmarks() {
    // 북마크 제거 로직
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobDetail?['title'] ?? ''),
      ),
      body: jobDetail == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobDetail!['title'] ?? '제목 없음',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              jobDetail!['companyName'] ?? '회사명 없음',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              '접수기간: ${jobDetail!['receiptPeriod'] ?? '정보 없음'}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: toggleBookmark,
              child: Text(isBookmarked ? '스크랩됨' : '스크랩'),
            ),
            SizedBox(height: 16),
            Text(
              '채용 내용',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(jobDetail!['description'] ?? '정보 없음'),
            // 추가 정보 섹션...
          ],
        ),
      ),
    );
  }
}

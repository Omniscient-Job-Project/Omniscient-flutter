import 'package:flutter/material.dart';

class ResumePage extends StatefulWidget {
  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  List<Map<String, dynamic>> resumes = [
    {
      'id': 1,
      'title': '첫 번째 이력서',
      'name': '홍길동',
      'email': 'hong@example.com',
      'phone': '010-1234-5678',
      'education': [
        {
          'school': '서울대학교',
          'major': '컴퓨터공학',
          'degree': '학사',
          'graduationYear': '2022'
        }
      ],
      'experience': [
        {
          'company': '카카오',
          'position': '소프트웨어 엔지니어',
          'startDate': '2021-06',
          'endDate': '2022-12',
          'description': '백엔드 개발 업무 수행'
        }
      ],
      'skills': 'Flutter, Vue.js, Node.js',
      'certificates': [
        {
          'name': '정보처리기사',
          'date': '2021-05'
        }
      ],
      'introduction': '저는 3년간의 개발 경력을 보유하고 있습니다.',
      'isOpen': false,
    },
  ];

  void toggleResume(int id) {
    setState(() {
      resumes = resumes.map((resume) {
        if (resume['id'] == id) {
          resume['isOpen'] = !resume['isOpen'];
        }
        return resume;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이력서 관리')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: resumes.map((resume) => _buildResumeItem(resume)).toList(),
      ),
    );
  }

  Widget _buildResumeItem(Map<String, dynamic> resume) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(resume['title']),
            trailing: Icon(
              resume['isOpen']
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onTap: () => toggleResume(resume['id']),
          ),
          if (resume['isOpen'])
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildResumeSection('개인 정보', [
                    '이름: ${resume['name']}',
                    if (resume['email'] != null) '이메일: ${resume['email']}',
                    if (resume['phone'] != null) '전화번호: ${resume['phone']}',
                  ]),
                  if (resume['education'] != null)
                    _buildResumeSection('학력', resume['education'].map<String>((edu) {
                      return '${edu['school']} - ${edu['major']} (${edu['graduationYear']})';
                    }).toList()),
                  if (resume['experience'] != null)
                    _buildResumeSection('경력', resume['experience'].map<String>((exp) {
                      return '${exp['company']} (${exp['startDate']} - ${exp['endDate']})\n직위: ${exp['position']}\n설명: ${exp['description']}';
                    }).toList()),
                  if (resume['skills'] != null)
                    _buildResumeSection('기술 스택', [resume['skills']]),
                  if (resume['certificates'] != null)
                    _buildResumeSection('자격증', resume['certificates'].map<String>((cert) {
                      return '${cert['name']} (${cert['date']})';
                    }).toList()),
                  if (resume['introduction'] != null)
                    _buildResumeSection('자기소개서', [resume['introduction']]),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResumeSection(String title, List<String> content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          ...content.map((item) => Text(item)).toList(),
        ],
      ),
    );
  }
}

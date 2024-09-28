import 'package:flutter/material.dart';
import '../repositories/notice_repository.dart';
import '../models/notice.dart';
import '/core/widgets/header.dart';
import '/core/widgets/footer.dart';
import 'notice_detail_screen.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final NoticeRepository _noticeRepository = NoticeRepository();
  Future<List<Notice>>? _notices;

  @override
  void initState() {
    super.initState();
    _notices = _noticeRepository.fetchNotices();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Header(), // 헤더 추가
          Expanded(
            child: FutureBuilder<List<Notice>>(
              future: _notices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('공지사항을 불러오는 중 오류가 발생했습니다.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('공지사항이 없습니다.'));
                }

                final notices = snapshot.data!;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Container(
                          width: screenWidth < 600 ? screenWidth * 0.95 : screenWidth * 0.8, // 작은 화면일 때는 95%, 큰 화면일 때는 80%
                          child: DataTable(
                            columnSpacing: screenWidth * 0.05, // 열 간격 조정
                            columns: const [
                              DataColumn(label: Text('번호')),
                              DataColumn(label: Text('제목')),
                              DataColumn(label: Text('등록일')),
                              DataColumn(label: Text('조회수')),
                            ],
                            rows: notices.map((notice) {
                              return DataRow(cells: [
                                DataCell(Text(notice.displayId.toString())),
                                DataCell(InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoticeDetailScreen(noticeId: notice.noticeId),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    notice.noticeTitle,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )),
                                DataCell(Text(
                                  DateTime.parse(notice.noticeCreateAt)
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                )),
                                DataCell(Text(notice.noticeViews.toString())),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Footer(), // 푸터 추가
        ],
      ),
    );
  }
}

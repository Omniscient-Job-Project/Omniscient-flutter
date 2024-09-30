import 'package:flutter/material.dart';
import '../models/notice.dart';
import '../repositories/notice_repository.dart';
import '/core/widgets/header.dart';  // Header 파일 가져오기
import '/core/widgets/footer.dart';  // Footer 파일 가져오기

class NoticeDetailScreen extends StatefulWidget {
  final int noticeId;

  NoticeDetailScreen({required this.noticeId});

  @override
  _NoticeDetailScreenState createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  Notice? notice;
  final NoticeRepository _noticeRepository = NoticeRepository();
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchNoticeDetail();
  }

  Future<void> fetchNoticeDetail() async {
    try {
      // 공지사항 상세 데이터 불러오기
      Notice fetchedNotice = await _noticeRepository.fetchNoticeById(widget.noticeId);
      setState(() {
        notice = fetchedNotice;
        isLoading = false;
      });

      // 조회수 업데이트 호출
      await incrementViewCount();
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      print('Error fetching notice: $error');
    }
  }

  Future<void> incrementViewCount() async {
    try {
      await _noticeRepository.incrementViewCount(widget.noticeId);
      if (notice != null) {
        setState(() {
          notice = notice!.copyWith(noticeViews: notice!.noticeViews + 1); // copyWith 사용
        });
      }
    } catch (error) {
      print('Error updating view count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(), // 헤더 추가, AppBar 위에 위치
          Expanded(
            child: Column(
              children: [
                AppBar(
                  title: Text('공지사항 상세보기'),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // 목록으로 돌아가기
                    },
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // 화면의 너비에 따라 유연하게 레이아웃을 조정
                      final screenWidth = constraints.maxWidth;

                      return isLoading
                          ? Center(child: CircularProgressIndicator())
                          : hasError
                          ? Center(child: Text('공지사항을 불러오는 중 오류가 발생했습니다.'))
                          : notice == null
                          ? Center(child: Text('공지사항이 존재하지 않습니다.'))
                          : SingleChildScrollView(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: screenWidth > 800
                                  ? 800
                                  : screenWidth * 0.9, // 큰 화면에서는 최대 800px, 작은 화면에서는 90% 너비
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notice!.noticeTitle,
                                  style: TextStyle(
                                    fontSize: screenWidth > 800 ? 28 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today),
                                        SizedBox(width: 5),
                                        Text(
                                          '등록일: ${notice!.noticeCreateAt.split(' ')[0]}',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.visibility),
                                        SizedBox(width: 5),
                                        Text(
                                          '조회수: ${notice!.noticeViews}',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    notice!.noticeContent,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context); // 목록으로 돌아가기
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    label: Text('목록으로 돌아가기'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue, // primary 대신 backgroundColor
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Footer(), // 푸터 추가, 화면 맨 아래 위치
        ],
      ),
    );
  }
}

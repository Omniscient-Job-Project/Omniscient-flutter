import 'package:flutter/material.dart';
import '../repositories/faq_repository.dart';
import '../models/faq.dart';
import '/core/widgets/header.dart'; // 헤더 파일 추가
import '/core/widgets/footer.dart'; // 푸터 파일 추가

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final FaqRepository _faqRepository = FaqRepository();
  Future<List<Faq>>? _faqs;
  int? _selectedFaqId;
  bool _incrementing = false;

  @override
  void initState() {
    super.initState();
    _faqs = _faqRepository.fetchFaqs();
  }

  void _toggleAnswer(int faqId, List<Faq> faqs) async {
    if (_selectedFaqId == faqId) {
      setState(() {
        _selectedFaqId = null;
      });
    } else {
      setState(() {
        _selectedFaqId = faqId;
      });
      await _incrementViewCount(faqId, faqs);
    }
  }

  Future<void> _incrementViewCount(int faqId, List<Faq> faqs) async {
    if (_incrementing) return;
    setState(() {
      _incrementing = true;
    });

    try {
      await _faqRepository.incrementFaqViews(faqId);
      setState(() {
        final faqIndex = faqs.indexWhere((faq) => faq.faqId == faqId);
        if (faqIndex != -1) {
          faqs[faqIndex] = faqs[faqIndex].copyWith(faqViews: faqs[faqIndex].faqViews + 1); // copyWith로 조회수 업데이트
        }
      });
    } catch (error) {
      print('조회수 업데이트 중 오류 발생: $error');
    } finally {
      setState(() {
        _incrementing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Header(), // 헤더 추가
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: screenWidth < 600 ? screenWidth * 0.95 : screenWidth * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '번호',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      '제목',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '조회수',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Faq>>(
              future: _faqs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('FAQ 목록을 불러오는 중 오류가 발생했습니다.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('FAQ 목록이 없습니다.'));
                }

                final faqs = snapshot.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Container(
                      width: screenWidth < 600 ? screenWidth * 0.95 : screenWidth * 0.8, // 작은 화면일 때는 95%, 큰 화면일 때는 80%
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: faqs.length,
                        itemBuilder: (context, index) {
                          final faq = faqs[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      (index + 1).toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: InkWell(
                                      onTap: () => _toggleAnswer(faq.faqId, faqs),
                                      child: Text(faq.question),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      faq.faqViews.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              if (_selectedFaqId == faq.faqId)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(faq.answer),
                                ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
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

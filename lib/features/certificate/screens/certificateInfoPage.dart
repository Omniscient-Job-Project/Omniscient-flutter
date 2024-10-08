// features/certificate/pages/certificate_info_page.dart
import 'package:flutter/material.dart';
import '../../mypage/models/scrap_item.dart';
import '../../mypage/repositories/scrap_repository.dart';
import '/core/widgets/header.dart';  // Header 파일 가져오기
import '/core/widgets/footer.dart';  // Footer 파일 가져오기
import '../widgets/certificateInfoList.dart';  // CertificateInfoList 임포트
import '../models/certificateInfo.dart';  // CertificateInfo 모델 임포트
import '../repositories/certificateInfoRepository.dart';  // Repository 임포트

class CertificateInfoPage extends StatefulWidget {
  @override
  _CertificateInfoPageState createState() => _CertificateInfoPageState();
}

class _CertificateInfoPageState extends State<CertificateInfoPage> {
  final CertificateInfoRepository _repository = CertificateInfoRepository();
  final ScrapRepository _scrapRepository = ScrapRepository();  // 스크랩 기능 추가

  List<CertificateInfo> _allCertificates = []; // 전체 자격증 정보
  List<CertificateInfo> _filteredCertificates = []; // 필터링된 자격증 정보
  List<CertificateInfo> _displayedCertificates = []; // 현재 페이지에 표시되는 자격증 정보
  List<String> _favoriteCertificates = [];  // 즐겨찾기된 자격증 ID 리스트

  int _currentPage = 1;
  final int _itemsPerPage = 5;
  String _searchKeyword = '';

  final TextEditingController _searchController = TextEditingController();

  // grdCd 값을 실제 값으로 설정 (필요한 값으로 교체)
  final String grdCd = '10';  // 실제 자격증 등급 코드로 설정

  @override
  void initState() {
    super.initState();
    _fetchCertificateInfo();  // 자격증 정보 로드
    _loadFavoriteCertificates();  // 즐겨찾기 상태 로드
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 모든 자격증 정보를 가져오고, 필터링 및 페이지네이션을 초기화
  void _fetchCertificateInfo() async {
    try {
      List<CertificateInfo> certificates = await _repository.fetchCertificates(grdCd, _currentPage, _itemsPerPage);
      setState(() {
        _allCertificates = certificates;
        _applyFilterAndPagination();  // 필터링 및 페이지네이션 적용
      });
    } catch (e) {
      // 에러 처리 (예: 스낵바 또는 오류 위젯 표시)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('자격증 데이터를 불러오는 중 오류 발생: $e')),
      );
    }
  }

  // 즐겨찾기 항목 로드
  void _loadFavoriteCertificates() async {
    List<ScrapItem> scraps = await _scrapRepository.loadScrapItems();
    setState(() {
      _favoriteCertificates = scraps
          .where((scrap) => scrap.jmNm != null)
          .map((scrap) => scrap.jmNm!)
          .toList();
    });
  }

  // 즐겨찾기 상태 토글
  void _toggleFavorite(CertificateInfo certificate) async {
    setState(() {
      if (_favoriteCertificates.contains(certificate.jmNm)) {
        _favoriteCertificates.remove(certificate.jmNm);
        _scrapRepository.removeScrapItemById(certificate.jmNm!);
      } else {
        _favoriteCertificates.add(certificate.jmNm!);
        _scrapRepository.addScrapItem(ScrapItem(
          jmNm: certificate.jmNm,
          instiNm: certificate.instiNm,
          grdNm: certificate.grdNm,
          preyyAcquQualIncRate: certificate.preyyAcquQualIncRate != null
              ? int.tryParse(certificate.preyyAcquQualIncRate.toString())
              : null,
          preyyQualAcquCnt: certificate.preyyQualAcquCnt != null
              ? int.tryParse(certificate.preyyQualAcquCnt.toString())
              : null,
          qualAcquCnt: certificate.qualAcquCnt != null
              ? int.tryParse(certificate.qualAcquCnt.toString())
              : null,
          statisYy: certificate.statisYy?.toString(),
          sumYy: certificate.sumYy?.toString(),
          instNm: null,
          contctNm: null,
          refineLotnoAddr: null,
          refineZipNo: null,
          regionNm: null,
        ));
      }
    });
  }

  // 검색어에 따라 데이터를 필터링하고, 페이지네이션을 적용
  void _applyFilterAndPagination() {
    // 검색어가 있을 경우 필터링
    if (_searchKeyword.isNotEmpty) {
      _filteredCertificates = _allCertificates.where((certificate) {
        return certificate.jmNm.toLowerCase().contains(_searchKeyword.toLowerCase()) ||
            certificate.instiNm.toLowerCase().contains(_searchKeyword.toLowerCase()) ||
            certificate.grdNm.toLowerCase().contains(_searchKeyword.toLowerCase()) ||
            certificate.preyyAcquQualIncRate.toString().contains(_searchKeyword.toLowerCase()) ||
            certificate.preyyQualAcquCnt.toString().contains(_searchKeyword.toLowerCase()) ||
            certificate.qualAcquCnt.toString().contains(_searchKeyword.toLowerCase()) ||
            certificate.statisYy.toString().contains(_searchKeyword.toLowerCase()) ||
            certificate.sumYy.toString().contains(_searchKeyword.toLowerCase());
      }).toList();
    } else {
      _filteredCertificates = List.from(_allCertificates);
    }

    // 현재 페이지에 맞는 데이터 추출
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex > _filteredCertificates.length) {
      startIndex = 0;
      _currentPage = 1;
    }
    if (endIndex > _filteredCertificates.length) {
      endIndex = _filteredCertificates.length;
    }
    _displayedCertificates = _filteredCertificates.sublist(startIndex, endIndex);
  }

  // 검색어가 변경될 때마다 필터링 및 페이지네이션 적용
  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
      _currentPage = 1; // 검색 시 페이지 초기화
      _applyFilterAndPagination();
    });
  }

  // 페이지를 변경할 때마다 표시되는 데이터를 업데이트
  void _changePage(int page) {
    setState(() {
      _currentPage = page;
      _fetchCertificateInfo(); // 페이지 변경 시 데이터 새로 고침
    });
  }

  @override
  Widget build(BuildContext context) {
    // 전체 페이지 수 계산
    int totalItems = _filteredCertificates.length;
    int totalPages = (totalItems / _itemsPerPage).ceil();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Header 높이 설정
        child: Header(), // Header 추가
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 검색창 추가
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
            SizedBox(height: 16),
            Text(
              '자격증 정보',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // 자격증 정보 리스트와 페이지네이션
            Expanded(
              child: _displayedCertificates.isEmpty
                  ? Center(child: Text('자격증 정보를 찾을 수 없습니다.'))
                  : Column(
                children: [
                  Expanded(
                    child: CertificateInfoList(
                      certificates: _displayedCertificates,
                      favoriteCertificates: _favoriteCertificates, // 즐겨찾기 상태 전달
                      onFavoriteToggle: _toggleFavorite, // 즐겨찾기 토글 전달
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildPagination(totalPages),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(), // Footer 추가
    );
  }

  // 페이지네이션 위젯 생성
  Widget _buildPagination(int totalPages) {
    if (totalPages <= 1) return SizedBox.shrink(); // 페이지가 1개 이하이면 표시하지 않음

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
        ),
        Text('$_currentPage / $totalPages'),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: _currentPage < totalPages ? () => _changePage(_currentPage + 1) : null,
        ),
      ],
    );
  }
}

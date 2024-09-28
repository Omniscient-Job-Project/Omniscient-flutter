import '../models/application.dart';

class ApplicationRepository {
  Future<List<Application>> fetchApplications() async {
    // 여기에서 실제 API 요청을 수행하는 부분을 구현합니다.
    // API 호출 부분은 실제 서버로 연동할 때 추가될 수 있습니다.
    await Future.delayed(Duration(seconds: 1)); // 더미 데이터 로드 시간 설정
    return [
      Application(
        id: 1,
        companyName: '테크 이노베이션',
        companyLogo: 'https://via.placeholder.com/80',
        position: '프론트엔드 개발자',
        applicationDate: DateTime(2024, 8, 15),
        status: 'IN_REVIEW',
        jobDescription: '최신 웹 기술을 활용한 사용자 중심의 웹 애플리케이션 개발',
        requirements: ['React 또는 Vue.js 경험', 'HTML, CSS, JavaScript 능숙', '반응형 웹 디자인 경험'],
        applicationProcess: ['서류 전형', '코딩 테스트', '기술 면접', '임원 면접'],
        currentStep: 1,
      ),
      Application(
        id: 2,
        companyName: '글로벌 소프트',
        companyLogo: 'https://via.placeholder.com/80',
        position: '풀스택 개발자',
        applicationDate: DateTime(2024, 8, 10),
        status: 'PASSED',
        jobDescription: '클라우드 기반 엔터프라이즈 솔루션 개발 및 유지보수',
        requirements: ['Node.js 백엔드 경험', 'AWS 또는 Azure 경험', 'SQL 및 NoSQL 데이터베이스 경험'],
        applicationProcess: ['서류 전형', '1차 기술 면접', '2차 임원 면접'],
        currentStep: 2,
      ),
      Application(
        id: 3,
        companyName: '데이터 솔루션즈',
        companyLogo: 'https://via.placeholder.com/80',
        position: 'UI/UX 개발자',
        applicationDate: DateTime(2024, 8, 5),
        status: 'REJECTED',
        jobDescription: '데이터 시각화 도구 및 대시보드 디자인 및 개발',
        requirements: ['D3.js 또는 유사 라이브러리 경험', 'Figma 또는 Sketch 사용 능력', 'UI/UX 디자인 원칙 이해'],
        applicationProcess: ['포트폴리오 검토', '기술 면접', '디자인 과제', '최종 면접'],
        currentStep: 0,
      ),
    ];
  }
}

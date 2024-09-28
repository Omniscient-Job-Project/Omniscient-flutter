import 'package:flutter/material.dart';
import '../models/term_section.dart';
import '../widgets/term_section_widget.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({Key? key}) : super(key: key);

  final List<TermSection> sections = [
    TermSection(
      title: "1. 서비스 이용",
      content: "전지적 구직자 시점 이용약관에 오신 것을 환영합니다. 본 약관은 사용자의 권리와 의무를 규정하며, 서비스 이용에 관한 사항을 안내합니다.",
    ),
    TermSection(
      title: "2. 사용자 의무",
      content: "사용자는 서비스를 이용함에 있어 법적 책임을 지며, 허위 정보를 입력하거나 불법적인 행위를 하지 않아야 합니다.",
    ),
    TermSection(
      title: "3. 개인정보 보호",
      content: "사용자의 개인정보는 관련 법령에 따라 보호됩니다. 개인정보 처리방침을 참조해 주세요.",
    ),
    TermSection(
      title: "4. 서비스 변경 및 중단",
      content: "회사는 서비스의 일부 또는 전체를 언제든지 변경하거나 중단할 수 있습니다.",
    ),
    TermSection(
      title: "5. 면책 조항",
      content: "회사는 서비스 이용으로 발생한 문제에 대해 책임을 지지 않습니다.",
    ),
    TermSection(
      title: "6. 약관 변경",
      content: "회사는 본 약관을 변경할 수 있으며, 변경된 약관은 웹사이트에 공지합니다.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE6F3FF),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이용약관',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 20),
                ...sections.map((section) => TermSectionWidget(section: section)).toList(),
                const SizedBox(height: 20),
                const Text(
                  '약관에 대한 문의는 전직시로 연락해 주세요.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // GitHub 페이지로 이동하는 로직
                  },
                  child: const Text('전직시 GitHub'),
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF3498DB),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

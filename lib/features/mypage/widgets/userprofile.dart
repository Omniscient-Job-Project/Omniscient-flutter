import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sidebar extends StatelessWidget {
  final Function(String) onItemSelected;

  Sidebar({required this.onItemSelected});

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'myHome', 'label': 'MyHome', 'icon': FontAwesomeIcons.home},
    {'name': 'profilePage', 'label': '프로필', 'icon': FontAwesomeIcons.user},
    {'name': 'resumePage', 'label': '이력서 관리', 'icon': FontAwesomeIcons.fileAlt},
    {'name': 'applicationsPage', 'label': '지원 현황', 'icon': FontAwesomeIcons.briefcase},
    {'name': 'scrapPage', 'label': '스크랩', 'icon': FontAwesomeIcons.bookmark},
    {'name': 'certificatesPage', 'label': '자격증 관리', 'icon': FontAwesomeIcons.certificate},
    {'name': 'withdrawalPage', 'label': '회원 탈퇴', 'icon': FontAwesomeIcons.userSlash},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: menuItems.map((item) {
          return ListTile(
            leading: Icon(item['icon'], color: Colors.blue),
            title: Text(item['label'], style: TextStyle(fontSize: 18)),
            onTap: () => onItemSelected(item['name']),
          );
        }).toList(),
      ),
    );
  }
}

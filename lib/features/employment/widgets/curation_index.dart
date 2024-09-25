import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurationIndex extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  CurationIndex({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildCurationItem('home', FontAwesomeIcons.home, '홈', Color(0xFF4CAF50)),
          buildCurationItem('employment', FontAwesomeIcons.briefcase, '고용센터', Color(0xFF2196F3)),
          buildCurationItem('elderlyJobs', FontAwesomeIcons.userFriends, '노인일자리', Color(0xFFFF9800)),
          buildCurationItem('womenJobs', FontAwesomeIcons.female, '여성일자리', Color(0xFFE91E63)),
          buildCurationItem('studentJobs', FontAwesomeIcons.graduationCap, '대학생일자리', Color(0xFF673AB7)),
        ],
      ),
    );
  }

  Widget buildCurationItem(String category, IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () => onCategorySelected(category),
      child: Column(
        children: [
          FaIcon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}
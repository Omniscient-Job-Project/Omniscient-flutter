import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omniscient/features/employment/models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;

  JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
            SizedBox(height: 8),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.building, size: 14, color: Color(0xFF3498DB)),
                SizedBox(width: 8),
                Expanded(child: Text(job.company, style: TextStyle(fontSize: 14, color: Color(0xFF34495E)))),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 14, color: Color(0xFFE74C3C)),
                SizedBox(width: 8),
                Expanded(child: Text(job.location, style: TextStyle(fontSize: 14, color: Color(0xFF34495E)))),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.briefcase, size: 14, color: Color(0xFF2ECC71)),
                SizedBox(width: 8),
                Expanded(child: Text(job.career, style: TextStyle(fontSize: 14, color: Color(0xFF34495E)))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/application.dart';

class ApplicationItem extends StatelessWidget {
  final Application application;
  final VoidCallback onTap;

  const ApplicationItem({
    Key? key,
    required this.application,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(application.companyLogo, width: 80, height: 80),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(application.position, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(application.companyName, style: TextStyle(fontSize: 16, color: Colors.grey)),
                    SizedBox(height: 4),
                    Text('지원일: ${application.formatDate()}'),
                  ],
                ),
              ),
              Chip(
                label: Text(application.getStatusText()),
                backgroundColor: _getStatusColor(application.status),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'IN_REVIEW':
        return Colors.yellow[700]!;
      case 'PASSED':
        return Colors.green[300]!;
      case 'REJECTED':
        return Colors.red[300]!;
      default:
        return Colors.grey;
    }
  }
}

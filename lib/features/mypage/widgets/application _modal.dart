import 'package:flutter/material.dart';
import '../models/application.dart';

class ApplicationModal extends StatelessWidget {
  final Application application;
  final VoidCallback onWithdraw;

  const ApplicationModal({
    Key? key,
    required this.application,
    required this.onWithdraw,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.network(application.companyLogo, width: 60, height: 60),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(application.position, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(application.companyName),
                      Text('지원일: ${application.formatDate()}'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('직무 설명', style: TextStyle(fontSize: 18)),
            Text(application.jobDescription),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onWithdraw,
              child: Text('지원 취소'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

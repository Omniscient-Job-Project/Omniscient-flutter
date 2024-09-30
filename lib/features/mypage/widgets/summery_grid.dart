import 'package:flutter/material.dart';

class SummaryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> summaryItems;

  SummaryGrid({required this.summaryItems});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: summaryItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = summaryItems[index];
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item['icon'], size: 40),
              SizedBox(height: 10),
              Text(item['label']),
              SizedBox(height: 5),
              Text('${item['value']}', style: TextStyle(fontSize: 24)),
            ],
          ),
        );
      },
    );
  }
}

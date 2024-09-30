import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtons extends StatelessWidget {
  final Function onRecommendationsClicked;

  ActionButtons({required this.onRecommendationsClicked});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.edit),
          label: Text('이력서 작성'),
          onPressed: () {
            Get.toNamed('/resumePage');
          },
        ),
        SizedBox(width: 10),
        ElevatedButton.icon(
          icon: Icon(Icons.campaign),
          label: Text('추천 채용공고'),
          onPressed: () {
            onRecommendationsClicked();
          },
        ),
      ],
    );
  }
}

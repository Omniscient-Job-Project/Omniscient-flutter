import 'package:flutter/material.dart';

class ResumeProfileImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onImageClick;

  ResumeProfileImage({required this.imageUrl, required this.onImageClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImageClick,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}

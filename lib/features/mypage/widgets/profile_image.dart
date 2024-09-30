import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onImageClick;

  const ProfileImage({required this.imageUrl, required this.onImageClick, required int width, required int height});

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

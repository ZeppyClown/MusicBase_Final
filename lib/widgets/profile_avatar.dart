import 'dart:io';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? networkUrl;
  final File? localImage;
  final VoidCallback? onEditTap;
  final double radius;

  const ProfileAvatar({
    Key? key,
    this.networkUrl,
    this.localImage,
    this.onEditTap,
    this.radius = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (localImage != null) {
      imageProvider = FileImage(localImage!);
    } else if (networkUrl != null && networkUrl!.isNotEmpty) {
      imageProvider = NetworkImage(networkUrl!);
    } else {
      imageProvider = const AssetImage('assets/images/default_avatar.png');
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
        if (onEditTap != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ),
      ],
    );
  }
}

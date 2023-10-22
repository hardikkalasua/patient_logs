import 'dart:io';

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? path;
  final double radius;
  const AvatarWidget({super.key, this.path, required this.radius});

  @override
  Widget build(BuildContext context) {
    if (path == null || path == '') {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage('assets/images/default_avatar.jpg'),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(File(path!)),
      );
    }
  }
}

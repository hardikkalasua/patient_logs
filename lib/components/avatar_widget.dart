import 'dart:io';

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final File? avatar;
  final double radius;
  const AvatarWidget({super.key, this.avatar, required this.radius});

  @override
  Widget build(BuildContext context) {
    if (avatar == null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage('assets/images/default_avatar.jpg'),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(avatar!),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/core/theme/wesee_colors.dart';
import 'package:wesee/app/core/theme/wesee_typography.dart';
import 'package:wesee/app/screens/profile/controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<WeseeColors>()!;
    final textTheme = Theme.of(context).extension<WeseeTypography>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton(
            onPressed: controller.signOut,
            child: const Text('Sign out'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.profileImageUrl != null)
              ClipOval(
                child: Image.network(
                  controller.profileImageUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              controller.fullName ?? '',
              style: textTheme.header1.copyWith(color: colorTheme.primaryBrand),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:wesee/app/screens/login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => {
            if (kIsWeb) {
              controller.googleSignInWeb()
            } else {
              controller.googleSignInNative()
            }
          },
          child: const Text('Google login'),
        ),
      ),
    );
  }
}

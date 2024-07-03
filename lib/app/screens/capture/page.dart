import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wesee/app/screens/capture/controller.dart';

class CaptureScreen extends GetView<CaptureController> {
  const CaptureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture'),
      ),
      body: GetBuilder<CaptureController>(
        builder: (_) {
          if (!controller.isInitialized.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: CameraPreview(controller.cameraController),
              ),
            ],
          );
        },
      ),
    );
  }
}
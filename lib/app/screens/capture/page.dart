import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'controller.dart';

class CaptureScreen extends GetView<CaptureController> {
  const CaptureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Capture'),
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
              ElevatedButton(
                onPressed: controller.processImage,
                child: const Text('Capture and Recognize Date'),
              ),
              Obx(() => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Recognized Date: ${controller.recognizedDate.value}',
                  style: const TextStyle(fontSize: 18),
                ),
              )),
            ],
          );
        },
      ),
    );
  }
}
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:wesee/app/services/supabase_service.dart';
import 'package:wesee/app/screens/expiration_date/controller.dart';

class CaptureController extends GetxController {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  RxBool isInitialized = false.obs;
  final textRecognizer = TextRecognizer();
  RxString recognizedDate = ''.obs;
  Timer? _timer;

  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController.initialize();
    isInitialized.value = true;
    update();

    _startPeriodicCheck();
  }

  void _startPeriodicCheck() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      processImage();
    });
  }

  Future<void> processImage() async {
    if (!isInitialized.value) return;

    try {
      final image = await cameraController.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final recognizedText = await textRecognizer.processImage(inputImage);

      final datePattern = RegExp(r'(\d{2,4})\.(\d{2})\.(\d{2})');
      final match = datePattern.firstMatch(recognizedText.text);

      if (match != null) {
        String year = match.group(1)!;
        final month = match.group(2)!;
        final day = match.group(3)!;

        if (year.length == 2) {
          int yearInt = int.parse(year);
          year = (yearInt >= 50 ? '19' : '20') + year;
        }

        recognizedDate.value = '$year.$month.$day';
        _stopCamera();
        _showDateDialog(recognizedDate.value);
      }
    } catch (e) {
      print('Error processing image: $e');
    }
  }

  void _stopCamera() {
    _timer?.cancel();
    cameraController.stopImageStream();
  }

  void _showDateDialog(String date) {
    Get.dialog(
      AlertDialog(
        title: const Text('날짜 인식됨'),
        content: Text('인식된 날짜: $date'),
        actions: [
          TextButton(
            child: const Text('취소'),
            onPressed: () {
              Get.back();
              _resumeCamera();
            },
          ),
          TextButton(
            child: const Text('계속'),
            onPressed: () {
              Get.back();
              _showNameInputDialog(date);
            },
          ),
        ],
      ),
    );
  }

  void _showNameInputDialog(String date) {
    final TextEditingController nameController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('항목 이름 입력'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: "항목 이름을 입력하세요"),
        ),
        actions: [
          TextButton(
            child: const Text('취소'),
            onPressed: () {
              Get.back();
              _resumeCamera();
            },
          ),
          TextButton(
            child: const Text('추가'),
            onPressed: () {
              Get.back();
              _addItemToSupabase(nameController.text, date);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addItemToSupabase(String name, String date) async {
    try {
      await supabaseService.addItem(name, date);
      Get.back();
      Get.find<ExpirationDateController>().refreshItems();
    } catch (e) {
      print('Error adding item to Supabase: $e');
      _resumeCamera();
    }
  }

  void _resumeCamera() {
    _startPeriodicCheck();
    cameraController.startImageStream((image) {});
  }

  @override
  void onClose() {
    _timer?.cancel();
    cameraController.dispose();
    textRecognizer.close();
    super.onClose();
  }
}
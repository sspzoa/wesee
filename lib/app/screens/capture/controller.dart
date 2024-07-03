import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CaptureController extends GetxController {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  RxBool isInitialized = false.obs;
  final textRecognizer = TextRecognizer();
  RxString recognizedDate = ''.obs;

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
  }

  Future<void> processImage() async {
    if (!isInitialized.value) return;

    try {
      final image = await cameraController.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final recognizedText = await textRecognizer.processImage(inputImage);

      // 날짜 형식 인식
      final datePattern = RegExp(r'\d{4}\.\d{2}\.\d{2}');
      final match = datePattern.firstMatch(recognizedText.text);

      if (match != null) {
        recognizedDate.value = match.group(0)!;
      } else {
        recognizedDate.value = 'No date found';
      }
    } catch (e) {
      print('Error processing image: $e');
      recognizedDate.value = '$e';
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    textRecognizer.close();
    super.onClose();
  }
}

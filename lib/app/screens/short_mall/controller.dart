import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ShortMallController extends GetxController {
  final RxBool isListening = false.obs;
  final RxString searchText = ''.obs;
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speech.initialize();
  }

  void startListening() async {
    if (await _speech.initialize()) {
      searchText.value = '';
      isListening.value = true;
      await _speech.listen(
        onResult: (result) {
          searchText.value = result.recognizedWords;
        },
      );
    }
  }

  void stopListening() {
    _speech.stop();
    isListening.value = false;
  }

  void performSearch() {
    if (searchText.value.isNotEmpty) {
      // TODO: 검색 기능 구현
      print('Searching for: ${searchText.value}');
    }
  }
}
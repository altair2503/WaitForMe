import 'package:flutter_tts/flutter_tts.dart';

class TtsService {

  static TtsService? _instance;
  final FlutterTts flutterTts = FlutterTts();

  TtsService() {
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.4);
  }

  static TtsService? get instance {
    if(_instance == null) {
      _instance = TtsService._();
      return _instance;
    }

    return _instance;
  }

  TtsService._();

  initialize() {
    _instance = TtsService._();
  }

  void homeSpeechForPWD() {
    flutterTts.speak("Hi! You can choose the buses you need.");
  }

  void driverSpeech(String remainingDistance) {
    flutterTts.speak("A person with disabilities is waiting for you $remainingDistance meters away");
  }

  void busStopSpeach(String stopName) {
    flutterTts.speak("The bus has arrived at the ${stopName} bus stop");
  }

  void lastStopSpeach(String stopName) {
    flutterTts.speak("You have arrived your $stopName bus stop. Press the get off button");
  }

}
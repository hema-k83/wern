import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CustomTTS {
  late FlutterTts flutterTts;
  String language = "en";

  CustomTTS();

  Future<bool> initTTS() async {
    flutterTts = FlutterTts();
    _setAwaitOptions();
    if (kIsWeb) {
      setConfig();
      return true;
    }
    if (!kIsWeb && Platform.isAndroid) {
      //isAndroid check {
      var engine = await _getDefaultEngine();
      var voice = await _getDefaultVoice();
      flutterTts.setErrorHandler((msg) {});
      if (voice && engine) {
        bool isLanguageAvailable = await flutterTts.isLanguageAvailable(
          language,
        );
        if (isLanguageAvailable) {
          setConfig();
          return true;
        }
      }
    }
    return false;
  }

  void setConfig() {
    flutterTts.setLanguage(language);
    flutterTts.setSpeechRate(0.5);
  }

  Future<bool> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      return true;
    }
    return false;
  }

  Future<bool> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      return true;
    }
    return false;
  }

  Future<void> speak(text) async {
    if (text != null) {
      if (text!.isNotEmpty) {
        await flutterTts.speak(text!);
      }
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}

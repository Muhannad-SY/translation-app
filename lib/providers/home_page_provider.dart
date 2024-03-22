import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class HomePageProvider extends ChangeNotifier {
  translationRequest() async {
    Uri url = Uri.parse(
        'https://35bd7536-3aea-4ab4-bcde-1532f6370667-00-1sde1sw05awy.pike.replit.dev/translate/?dest=$outPutLanguageCode&text=${inputText.text}');

    var request = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (request.statusCode == 200) {
      print(convert.jsonDecode(request.body));
      this.outputText = convert.jsonDecode(request.body)['text'];
    } else {
      print('the request filed');
    }

    notifyListeners();
  }

  //this a map include the languages which are using in translation function
  Map<String, String> languages = {
    'Urdu': 'ur',
    'English': 'en',
    'France': 'fr',
    'Punjabi': 'punjabi',
    'Arabic': 'ar',
    'Turkey': 'tr',
    'Hindi': 'hi',
  };

// Output text control
  String outputText = '';
  String outputLanguage = 'chose';
  String outPutLanguageCode = '';

  void editOutputText(String val ) {
    outputText = val; //

    notifyListeners();
  }

  void changeOutputLanguage(String val , String value) {
    outputLanguage = val;
    this.outPutLanguageCode = value;
    notifyListeners();
  }

// input text control
  String inputLanguage = 'English';
  FocusNode focusNode = FocusNode();
  TextEditingController inputText = TextEditingController();

  void changeInputLanguage(String val) {
    inputLanguage = val;
    print(this.inputLanguage);
    notifyListeners();
  }

  void clearInput() {
    inputText.clear();
    notifyListeners();
  }

  // change input & output languages by each other
   void exchangeLanguages() {
    var y = inputLanguage;
    var x = outputLanguage;
    inputLanguage = x;
    outputLanguage = y;
        languages.forEach((key , val ) {
      if(key == y){
        outPutLanguageCode = val;
      }
    });
    notifyListeners();
  }

// voice recoding cotrollers
  bool isRecord = false;
  SpeechToText speech = SpeechToText();
  String recordedText = '';

  void initalizeSpeaker() async {
    await speech.initialize();
    notifyListeners();
  }

  recordSpeechToText() async {
    if (isRecord) {
      print('yes strated');
      await speech.listen(
          localeId: this.languages[this.inputLanguage],
          onResult: (val) {
            print('${val.recognizedWords}');
            inputText.text = val.recognizedWords;
            notifyListeners();
          });
    } else if (isRecord == false) {
      print('no stop');
      speech.stop();
    }
    notifyListeners();
  }

  void changeRecordState() {
    isRecord = !isRecord;
    notifyListeners();
  }

  void showMessagee(BuildContext context, message, var color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: color, content: Text('$message')),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:dictionary/pages/definition_page.dart';
import 'package:dictionary/services/api_services.dart';
import 'package:dictionary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchQuery = TextEditingController();
  List<String> suggestions = [
    // "agar",
    // "gar",
    // "Graf",
    // "Agra",
    // "Gary",
    // "gar",
    // "Graf",
    // "gar",
    // "Graf",
    // "gar",
    // "Graf",
    // "garb"
  ];
  Timer _debounce;
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        // onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
    });
    print("${result.recognizedWords} - ${result.finalResult}");
    if (result.finalResult == true && result.recognizedWords.isNotEmpty) {
      _searchQuery.text = result.recognizedWords;
    }
  }

  // void soundLevelListener(double level) {
  //   minSoundLevel = min(minSoundLevel, level);
  //   maxSoundLevel = max(maxSoundLevel, level);
  //   print("sound level $level: $minSoundLevel - $maxSoundLevel ");
  //   setState(() {
  //     this.level = level;
  //   });
  // }

  void errorListener(SpeechRecognitionError error) {
    print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    print(
        "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }

  // void _switchLang(selectedVal) {
  //   setState(() {
  //     _currentLocaleId = selectedVal;
  //   });
  //   print(selectedVal);
  // }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      if (_searchQuery.text != null && _searchQuery.text.trim().isNotEmpty) {
        var res = await checkSpelling(_searchQuery.text);
        print(res.toJson());
        var tempSuggestions = res.elements?.first?.errors?.first?.suggestions;
        if (tempSuggestions != null) {
          setState(() {
            suggestions = tempSuggestions;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchDecoration = InputDecoration(
        fillColor: Colors.white,
        hintText: "Search for a word",
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon:
              Icon(speech.isListening ? Icons.mic_rounded : Icons.mic_outlined),
          onPressed: _hasSpeech
              ? !_hasSpeech || speech.isListening
                  ? null
                  : startListening
              : initSpeechState,
        ),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: DictionaryTheme.secondaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(32),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            )));

    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [DictionaryTheme.primaryColor, Color(0xFFe22d4e)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 24),
              child: Center(
                child: Text(
                  "Simple Dictionary",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: DictionaryTheme.secondaryColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchQuery,
                decoration: searchDecoration,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: suggestions != null && suggestions.isNotEmpty
                  ? Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 15,
                      child: Container(
                          height: MediaQuery.of(context).size.height / 1.8,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey,
                                  ),
                              shrinkWrap: true,
                              itemCount: suggestions.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DefinitionPage(),
                                        settings: RouteSettings(
                                          arguments: {
                                            "word": suggestions[index]
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(suggestions[index]),
                                );
                              })),
                    )
                  : Text("Search for something"),
            )
          ],
        ),
      )),
    );
  }
}

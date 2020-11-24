import 'dart:async';

import 'package:dictionary/pages/definition_page.dart';
import 'package:dictionary/services/api_services.dart';
import 'package:dictionary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchQuery = TextEditingController();
  List<String> suggestions = [
    "agar",
    "gar",
    "Graf",
    "Agra",
    "Gary",
    "gar",
    "Graf",
    "gar",
    "Graf",
    "gar",
    "Graf",
    "garb"
  ];
  Timer _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      var res = await checkSpelling(_searchQuery.text);
      print(res.toJson());
      var tempSuggestions = res.elements?.first?.errors?.first?.suggestions;
      if (tempSuggestions != null) {
        setState(() {
          suggestions = tempSuggestions;
        });
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
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [DictionaryTheme.primaryColor, Color(0xFFe22d4e)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 24),
              child: Text(
                "Simple Dictionary",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: DictionaryTheme.secondaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchQuery,
                decoration: InputDecoration(
                    // labelText: "Search for a word",
                    fillColor: Colors.white,
                    hintText: "Search for a word",
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic),
                    // contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32),
                        ),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32),
                        ),
                        borderSide:
                            BorderSide(color: DictionaryTheme.secondaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(32),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: suggestions != null && suggestions.length > 0
                  ? Material(
                      elevation: 15,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          height: MediaQuery.of(context).size.height / 1.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
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

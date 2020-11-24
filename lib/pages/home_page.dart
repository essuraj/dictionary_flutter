import 'dart:async';
import 'dart:developer';

import 'package:dictionary/pages/definition_page.dart';
import 'package:dictionary/services/api_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchQuery = TextEditingController();
  List<String> suggestions = ["agar", "gar", "Graf", "Agra", "Gary", "garb"];
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Dictionary"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchQuery,
                decoration: InputDecoration(labelText: "Search for a word"),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...suggestions.map((e) => ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DefinitionPage(),
                              // Pass the arguments as part of the RouteSettings. The
                              // DetailScreen reads the arguments from these settings.
                              settings: RouteSettings(
                                arguments: {"word": e},
                              ),
                            ),
                          );
                        },
                        title: Text(e),
                      ))
                ],
              ),
            )
          ],
        ));
  }
}

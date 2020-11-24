import 'dart:async';
import 'dart:developer';

import 'package:dictionary/pages/definition_page.dart';
import 'package:dictionary/services/api_services.dart';
import 'package:dictionary/utils/theme.dart';
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
    // if (_debounce?.isActive ?? false) _debounce.cancel();
    // _debounce = Timer(const Duration(milliseconds: 1000), () async {
    //   var res = await checkSpelling(_searchQuery.text);
    //   print(res.toJson());
    //   var tempSuggestions = res.elements?.first?.errors?.first?.suggestions;
    //   if (tempSuggestions != null) {
    //     setState(() {
    //       suggestions = tempSuggestions;
    //     });
    //   }
    // });
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
        // appBar: AppBar(
        //   title: Text("Dictionary"),
        //   centerTitle: true,
        // ),
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [DictionaryTheme.primaryColor, Color(0xFFe22d4e)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Center(
              child: Padding(
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
                          borderSide: BorderSide(
                              color: DictionaryTheme.secondaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            const Radius.circular(32),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ))),
                ),
              ),
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
      ),
    ));
  }
}

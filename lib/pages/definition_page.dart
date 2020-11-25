import 'package:dictionary/models/definition_response.dart';
import 'package:dictionary/services/api_services.dart';
import 'package:dictionary/utils/theme.dart';
import 'package:dictionary/widgets/definition_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DefinitionPage extends StatefulWidget {
  @override
  _DefinitionPageState createState() => _DefinitionPageState();
}

class _DefinitionPageState extends State<DefinitionPage> {
  String word;
  String errorMessage;
  FlutterTts flutterTts;
  DefinitionResponse definition;
  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var args =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      var wordToSearch = args["word"];
      if (wordToSearch != null) {
        setState(() {
          word = wordToSearch;
        });
        try {
          var res = await getDefinition(wordToSearch);
          if (res.metadata != null) {
            setState(() {
              definition = res;
            });
          } else {
            setState(() {
              errorMessage = "No matching entry found for the word " + word;
            });
          }
        } catch (e) {
          setState(() {
            errorMessage = e.toString();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
              word,
              style: textTheme.headline6.copyWith(
                color: DictionaryTheme.secondaryColor,
              ),
            )),
          ),
          SliverFillRemaining(
              fillOverscroll: true,
              child: definition == null
                  ? errorMessage == null
                      ? Center(
                          child: CircularProgressIndicator(
                          backgroundColor: DictionaryTheme.primaryColor,
                        ))
                      : Center(child: Text(errorMessage))
                  : Column(
                      children: [
                        ListTile(
                          trailing: Icon(Icons.volume_up_outlined),
                          title: Text(
                            "Pronounciation",
                            style: textTheme.bodyText1
                                .copyWith(color: Colors.grey),
                          ),
                          onTap: () async {
                            await flutterTts.speak(word);
                          },
                        ),
                        ...definition.results.map((e) => DefinitionCard(
                              result: e,
                            ))
                      ],
                    )),
        ],
      ),
    );
  }
}

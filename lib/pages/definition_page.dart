import 'package:flutter/material.dart';

class DefinitionPage extends StatefulWidget {
  @override
  _DefinitionPageState createState() => _DefinitionPageState();
}

class _DefinitionPageState extends State<DefinitionPage> {
  String word;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var args =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      setState(() {
        word = args["word"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                word,
                style: textTheme.headline2,
              ),
            ],
          )),
    );
  }
}

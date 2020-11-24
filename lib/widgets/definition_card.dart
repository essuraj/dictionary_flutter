import 'package:dictionary/models/definition_response.dart';
import 'package:dictionary/widgets/entry_card.dart';
import 'package:flutter/material.dart';

class DefinitionCard extends StatelessWidget {
  final Result result;
  DefinitionCard({Key key, @required this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(result.language),
          Text(result.type),
          ...result.lexicalEntries.map((e) => EntryCard(entry: e))
        ],
      ),
    );
  }
}

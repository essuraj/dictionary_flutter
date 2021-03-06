import 'package:dictionary/models/definition_response.dart';
import 'package:dictionary/widgets/entry_card.dart';
import 'package:flutter/material.dart';

class DefinitionCard extends StatelessWidget {
  final Result result;
  DefinitionCard({Key key, @required this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...result.lexicalEntries.map((e) => EntryCard(entry: e))],
      ),
    );
  }
}

import 'package:dictionary/models/definition_response.dart';
import 'package:dictionary/widgets/sense_card.dart';
import 'package:flutter/material.dart';

class EntryCard extends StatelessWidget {
  final LexicalEntry entry;
  EntryCard({Key key, @required this.entry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            entry.lexicalCategory.text,
            style: textTheme.overline,
          ),
          ...entry.entries.expand((e) => e.senses.map((sense) => SenseCard(
                sense: sense,
              )))
        ],
      ),
    );
  }
}
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
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.lexicalCategory.text,
            style: textTheme.bodyText1.copyWith(color: Colors.grey),
          ),
          Divider(
            thickness: 1,
          ),
          ...entry.entries.expand((e) => e.senses.map((sense) => SenseCard(
                sense: sense,
              )))
        ],
      ),
    );
  }
}
